Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9187564C5FE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 10:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiLNJcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 04:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiLNJcT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 04:32:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C95588;
        Wed, 14 Dec 2022 01:32:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NX98r58LPz6J6Bw;
        Wed, 14 Dec 2022 17:31:08 +0800 (CST)
Received: from localhost (10.81.204.207) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 09:32:15 +0000
Date:   Wed, 14 Dec 2022 09:32:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Han Xu <han.xu@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] iio: accel: add the new entry in driver for
 fxls8967af
Message-ID: <20221214093214.00000a03@Huawei.com>
In-Reply-To: <84bd582c-1dde-822c-48b7-025887fd0203@linaro.org>
References: <20221213171536.1880089-1-han.xu@nxp.com>
        <20221213171536.1880089-3-han.xu@nxp.com>
        <84bd582c-1dde-822c-48b7-025887fd0203@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.204.207]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Tue, 13 Dec 2022 19:53:30 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/12/2022 18:15, Han Xu wrote:
> > Add this new device entry in the driver id table.
> > 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > 
> > ---
> > changes in v2
> > - change chip info orders
> > ---
> >  drivers/iio/accel/fxls8962af-core.c | 7 +++++++
> >  drivers/iio/accel/fxls8962af-i2c.c  | 2 ++
> >  drivers/iio/accel/fxls8962af.h      | 1 +
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> > index 98811e4e16bb..c3589c3084ee 100644
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -127,6 +127,7 @@
> >  #define FXLS8962AF_DEVICE_ID			0x62
> >  #define FXLS8964AF_DEVICE_ID			0x84
> >  #define FXLS8974CF_DEVICE_ID			0x86
> > +#define FXLS8967AF_DEVICE_ID			0x87
> >  
> >  /* Raw temp channel offset */
> >  #define FXLS8962AF_TEMP_CENTER_VAL		25
> > @@ -765,6 +766,12 @@ static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
> >  		.channels = fxls8962af_channels,
> >  		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> >  	},
> > +	[fxls8967af] = {
> > +		.chip_id = FXLS8967AF_DEVICE_ID,
> > +		.name = "fxls8967af",
> > +		.channels = fxls8962af_channels,
> > +		.num_channels = ARRAY_SIZE(fxls8962af_channels),
> > +	},
> >  	[fxls8974cf] = {
> >  		.chip_id = FXLS8974CF_DEVICE_ID,
> >  		.name = "fxls8974cf",
> > diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> > index 17dd56756ff9..a8944b255a28 100644
> > --- a/drivers/iio/accel/fxls8962af-i2c.c
> > +++ b/drivers/iio/accel/fxls8962af-i2c.c
> > @@ -30,6 +30,7 @@ static int fxls8962af_probe(struct i2c_client *client)
> >  static const struct i2c_device_id fxls8962af_id[] = {
> >  	{ "fxls8962af", fxls8962af },
> >  	{ "fxls8964af", fxls8964af },
> > +	{ "fxls8967af", fxls8967af },
> >  	{ "fxls8974cf", fxls8974cf },
> >  	{}
> >  };
> > @@ -38,6 +39,7 @@ MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> >  static const struct of_device_id fxls8962af_of_match[] = {
> >  	{ .compatible = "nxp,fxls8962af" },
> >  	{ .compatible = "nxp,fxls8964af" },
> > +	{ .compatible = "nxp,fxls8967af" },
> >  	{ .compatible = "nxp,fxls8974cf" },  
> 
> This is confusing. The I2C ID table has driver data, but OF ID table
> hasn't. So are they compatible or not?

Due to some evilness in i2c that 'works' as long as the two arrays have
matching entries.  As a general rule we prefer to have the data in both, check
the firmware table first and only then fallback to i2c_device_id data on the
basis it is less fragile.

The evilness in i2c is that the search for match data will use the dt compatible
stripped of the vendor prefix and string match that against the i2c_device_id table.

Nice to clean this up, but not necessarily in this series (fine if it is though!)

Jonathan

> 
> Best regards,
> Krzysztof
> 

