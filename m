Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF106629EF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjAIPbA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 9 Jan 2023 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbjAIPav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 10:30:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDEA1A8
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 07:30:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NrHnX53L7z6HJdl;
        Mon,  9 Jan 2023 23:25:20 +0800 (CST)
Received: from localhost (10.45.145.18) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 15:30:17 +0000
Date:   Mon, 9 Jan 2023 15:30:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marten Lindahl <martenli@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        =?ISO-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: Make irq handling more
 generic
Message-ID: <20230109153016.0000372a@Huawei.com>
In-Reply-To: <Y7v7OmIxlS/UvmSA@axis.com>
References: <20221220214959.2289330-1-marten.lindahl@axis.com>
        <20221220214959.2289330-2-marten.lindahl@axis.com>
        <20221223155313.00a89322@jic23-huawei>
        <Y7v7OmIxlS/UvmSA@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.45.145.18]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Jan 2023 12:32:10 +0100
Marten Lindahl <martenli@axis.com> wrote:
> > > +			if (ret < 0) {
> > > +				dev_err(&client->dev,
> > > +					"unable to setup iio triggered buffer\n");
> > > +				return ret;
> > > +			}
> > >  		}
> > >  
> > > -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > > -						NULL, vcnl4010_irq_thread,
> > > -						IRQF_TRIGGER_FALLING |
> > > -						IRQF_ONESHOT,
> > > -						"vcnl4010_irq",
> > > -						indio_dev);
> > > -		if (ret < 0) {
> > > -			dev_err(&client->dev, "irq request failed\n");
> > > -			return ret;
> > > +		if (data->chip_spec->irq_thread) {
> > > +			ret = devm_request_threaded_irq(&client->dev,
> > > +							client->irq, NULL,
> > > +							data->chip_spec->irq_thread,
> > > +							IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > +							"vcnl4000_irq",
> > > +							indio_dev);
> > > +			if (ret < 0) {
> > > +				dev_err(&client->dev, "irq request failed\n");
> > > +				return ret;
> > > +			}
> > >  		}
> > >  
> > >  		ret = vcnl4010_probe_trigger(indio_dev);  
> > Does it make sense to add the trigger even if we have no irq_thread?
> >   
> The irq_thread is dependent on the iio_event_interface, but I can not see that
> the trigger is dependent on the irq_thread. I am not sure of this.

The trigger sets up the infrastructure (under the hood it's a software
only demux of interrupts) to route to the registered consumers of the trigger.
That happens via iio_trigger_poll[_chained]() - the call in question is in the
irq handler, so whilst you can register the trigger without the irq_thread, it
won't do anything useful (hence I would not register it).

Jonathan

> 
> Kind regards
> Mårten
> >   

