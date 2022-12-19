Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18999650969
	for <lists+linux-iio@lfdr.de>; Mon, 19 Dec 2022 10:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLSJj4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Dec 2022 04:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLSJjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2022 04:39:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2896249;
        Mon, 19 Dec 2022 01:39:53 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbF213xkJz6HJd5;
        Mon, 19 Dec 2022 17:35:53 +0800 (CST)
Received: from localhost (10.45.149.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 09:39:49 +0000
Date:   Mon, 19 Dec 2022 09:39:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Han Xu <han.xu@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Clark Wang" <xiaoning.wang@nxp.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: accel: fxls8962af: add new
 compatible string
Message-ID: <20221219093946.00007411@Huawei.com>
In-Reply-To: <76c5cdd9-7b90-7ce5-02c4-a2a6e5bb3a30@linaro.org>
References: <20221213171536.1880089-1-han.xu@nxp.com>
        <20221213171536.1880089-5-han.xu@nxp.com>
        <76c5cdd9-7b90-7ce5-02c4-a2a6e5bb3a30@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Wed, 14 Dec 2022 10:54:32 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/12/2022 18:15, Han Xu wrote:
> > Add new compatible string for the NXP FXLS8967AF accelerometer sensor.
> > 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > 
> > ---
> > changes in v3
> > - Start commit message in capital
> > - Describe all these chips are compatible
> > ---
> >  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml         | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> > index 65ce8ea14b52..8f07ade21abb 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> > @@ -14,12 +14,16 @@ description: |
> >    SPI and I2C interface.
> >      https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
> >      https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> > +    https://www.nxp.com/docs/en/data-sheet/FXLS8967AF.pdf
> >  
> >  properties:
> >    compatible:
> > +    description:
> > +      These chips are compatible with each other, just have different IDs.  
> 
> As pointed in other mail, the chips are not compatible, so drop the comment.

The difference is an ID register.  Given we have had a bunch of cases of board
manufacturers swapping parts that aren't always compatible we have an old
pattern that we are fixing of rejecting unmatched who am I registers.

This driver should be relaxed to just print a message when the value doesn't
match - that was the compromise we reached with still pointing out possible
compatibility problems, whilst assuming the dts is correct.
Even better would be to make it a little more clever so it doesn't bother moaning
about part changes if the driver knows the new ID is compatible.

Once that's done the comment would reflect how we treat it in the driver
(which shouldn't matter to the binding anyway).

I'm not entirely sure why this driver has handling to allow for different channel
sets, but assume there are more parts to be upstreamed where that flexibility will
be useful.

Jonathan



> 
> Best regards,
> Krzysztof
> 

