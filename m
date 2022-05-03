Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538FC5189DC
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiECQau (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 12:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiECQas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 12:30:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149393A5CA
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 09:27:15 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt4zg4tgLz67ycB;
        Wed,  4 May 2022 00:24:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 18:27:12 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 17:27:11 +0100
Date:   Tue, 3 May 2022 17:27:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Akinobu Mita" <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        "David Lechner" <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        "Sean Nyekjaer" <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6ni?= =?ISO-8859-1?Q?g?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 02/92] iio: accel: adxl313: Fix alignment for DMA safety
Message-ID: <20220503172710.00003fb0@Huawei.com>
In-Reply-To: <8536c4e0-e2f7-b5bd-bf49-e28db42a4b50@metafoo.de>
References: <20220503085935.1533814-1-jic23@kernel.org>
        <20220503085935.1533814-3-jic23@kernel.org>
        <8536c4e0-e2f7-b5bd-bf49-e28db42a4b50@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 May 2022 15:11:26 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 5/3/22 10:58, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ____cacheline_aligned is insufficient guarantee for non-coherent DMA.
> > Switch to the update IIO_ALIGN definition.
> >
> > Fixes: 636d44633039 ("iio: accel: Add driver support for ADXL313")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   drivers/iio/accel/adxl313_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> > index 9e4193e64765..508fccbd4347 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -46,7 +46,7 @@ EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
> >   struct adxl313_data {
> >   	struct regmap	*regmap;
> >   	struct mutex	lock; /* lock to protect transf_buf */
> > -	__le16		transf_buf ____cacheline_aligned;
> > +	__le16		transf_buf __aligned(IIO_ALIGN);  
> How about making __aligned(IIO_ALIGN) a macro in case we ever want to 
> change it.

Could do I suppose, though scripts are already getting confused enough
at __aligned() :( (Try running check patch on this series!)

That can be fixed but adds another step.

I also can't actually think of why we would want to change an
align force to something other than an align force.  The value of
IIO_ALIGN might well change of course.

Jonathan



> >   };
> >   
> >   static const int adxl313_odr_freqs[][2] = {  
> 
> 

