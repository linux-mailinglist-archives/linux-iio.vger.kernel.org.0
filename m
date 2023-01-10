Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37C664069
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjAJM0D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbjAJMZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 07:25:16 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7447304
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2023 04:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673353466;
  x=1704889466;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=q04U0UKG6h3xZxDLjlFaQ4Q2ZNfHNJKwp/ZmGlpI0Ik=;
  b=X6eKilFLN/Bk1LDB2Et+9uOQ/Inxu73mMNI5Hcjgs/EuKTa6LvUVHPrI
   Nn2kLmGjLTUXhCYl03WlVGrlk3JxlBAEjVR6RSD4Bw46D5/Ubj+xiQo0j
   ESzCp2a/2X4JJvXCPudxzuYXSCJMhkcngOIu4ReVY4ZEyf3wyux6iSGfu
   k4HV+zb5z1qmkQMkWTk9l2e6RCF8RmNvjP4Y2+wMXrJyGRKCeRL1t4gzS
   q13jGsB6UN1Pv9AUs+bfYMegT/MW9bq3uuDibihSNPnTMtPrEPkRaYvDg
   SLxOKjqU7J0i5zmz+IlK/C/JNP1Z5L9APnMKCoBGGHxHcwpLlu4yCSC71
   Q==;
Date:   Tue, 10 Jan 2023 13:24:24 +0100
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: Make irq handling more generic
Message-ID: <Y71Y+DlCm3V7x4UE@axis.com>
References: <20221220214959.2289330-1-marten.lindahl@axis.com>
 <20221220214959.2289330-2-marten.lindahl@axis.com>
 <20221223155313.00a89322@jic23-huawei>
 <Y7v7OmIxlS/UvmSA@axis.com>
 <20230109153016.0000372a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109153016.0000372a@Huawei.com>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 09, 2023 at 04:30:16PM +0100, Jonathan Cameron wrote:
> On Mon, 9 Jan 2023 12:32:10 +0100
> Marten Lindahl <martenli@axis.com> wrote:
> > > > +			if (ret < 0) {
> > > > +				dev_err(&client->dev,
> > > > +					"unable to setup iio triggered buffer\n");
> > > > +				return ret;
> > > > +			}
> > > >  		}
> > > >  
> > > > -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > > > -						NULL, vcnl4010_irq_thread,
> > > > -						IRQF_TRIGGER_FALLING |
> > > > -						IRQF_ONESHOT,
> > > > -						"vcnl4010_irq",
> > > > -						indio_dev);
> > > > -		if (ret < 0) {
> > > > -			dev_err(&client->dev, "irq request failed\n");
> > > > -			return ret;
> > > > +		if (data->chip_spec->irq_thread) {
> > > > +			ret = devm_request_threaded_irq(&client->dev,
> > > > +							client->irq, NULL,
> > > > +							data->chip_spec->irq_thread,
> > > > +							IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > > +							"vcnl4000_irq",
> > > > +							indio_dev);
> > > > +			if (ret < 0) {
> > > > +				dev_err(&client->dev, "irq request failed\n");
> > > > +				return ret;
> > > > +			}
> > > >  		}
> > > >  
> > > >  		ret = vcnl4010_probe_trigger(indio_dev);  
> > > Does it make sense to add the trigger even if we have no irq_thread?
> > >   
> > The irq_thread is dependent on the iio_event_interface, but I can not see that
> > the trigger is dependent on the irq_thread. I am not sure of this.
> 
> The trigger sets up the infrastructure (under the hood it's a software
> only demux of interrupts) to route to the registered consumers of the trigger.
> That happens via iio_trigger_poll[_chained]() - the call in question is in the
> irq handler, so whilst you can register the trigger without the irq_thread, it
> won't do anything useful (hence I would not register it).
> 
> Jonathan

Thanks for clarifying this. I will bind it to the irq_thread then.

Kind regards
Mårten
> 
> > 
> > Kind regards
> > Mårten
> > >   
> 
