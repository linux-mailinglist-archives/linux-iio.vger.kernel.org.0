Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E37689012
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBCHDq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 02:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBCHDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 02:03:44 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEF4860A;
        Thu,  2 Feb 2023 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675407804; x=1706943804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TgWBWT+IFUzF9icb3lQ8a18CFkOqA7ocw41oKgnicY=;
  b=nGzZO+7tRve7GGh6snlg2Nnty5JpPMyNX2DCAwkjkjwp4E8B3bvtOiKh
   k1quZP877K3JF69Bv8OZjbJvswFahlW6Bi69I1Eo8Kv7GcseoE7ULJ1C7
   FDgPvorbk/xe2affYJ5t+kw3uHz18GbvTvh4wfXzajpmLOR7bFpZ4d8hj
   U2wSn/A0TQxrUDDsmTh9V0dOH6QXVyE/BRK5LfPH0rOSL8Qx5/Rtv0hgG
   X4KV16++p17rfUmiJ0vtsUnPTg5+GiKyRuWAX35TzGCFTxgSRpk0/XRX+
   HFBrSM0Jc5ub6pxYz6NVUyRKZ+ipJi41N2qKNCFpRW1FsojouSRopEf8F
   A==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669071600"; 
   d="scan'208";a="28843869"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Feb 2023 08:03:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 03 Feb 2023 08:03:21 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 03 Feb 2023 08:03:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675407801; x=1706943801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TgWBWT+IFUzF9icb3lQ8a18CFkOqA7ocw41oKgnicY=;
  b=CgXCG4S2MQPDq+3tkK0lBp4bDZOW59fc6HO95WoaKZwxUCBRdYUpYgSl
   /HYGjAgvKMvEdmJ5GtdSQWV7NfSpMt//4K2KfmQrKi3FTNyG8h3usONIf
   9/7R+2eXjc24Wis/GAuA59zskCIfvluafihD0l4AkjrYdXcpze/C1i9a0
   dlVbKvxzR4GJaYJ+XX/RUzr8gZq0PW1FtN9jfYxmgyEVOv7xldtxZ08T6
   7IzNcsCVdyUf0Z7Jwl0iSvlybAQndKKlfBx4D8k8vn1NXrnvFZV4LYoIy
   tBmz/7sqaTOez592UsW0FOZ1YRCCOovBlGQFvQc/ydvjjIN/F3liBb4ek
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669071600"; 
   d="scan'208";a="28843868"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Feb 2023 08:03:21 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 68B9A280056;
        Fri,  3 Feb 2023 08:03:21 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
Date:   Fri, 03 Feb 2023 08:03:18 +0100
Message-ID: <1922814.PYKUYFuaPT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230202171052.502ec666@jic23-huawei>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com> <20230201121343.vk2t2dfpbvhflols@pengutronix.de> <20230202171052.502ec666@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Am Donnerstag, 2. Februar 2023, 18:10:52 CET schrieb Jonathan Cameron:
> On Wed, 1 Feb 2023 13:13:43 +0100
> 
> Marco Felsch <m.felsch@pengutronix.de> wrote:
> > Hi Alexander,
> > 
> > On 23-01-31, Alexander Stein wrote:
> > > Hi Marco,
> > > 
> > > thanks for the feedback.
> > > 
> > > Am Dienstag, 31. Januar 2023, 11:48:16 CET schrieb Marco Felsch:
> > > > Hi Alexander,
> > > > 
> > > > On 23-01-31, Alexander Stein wrote:
> > > > > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > > > > this ADC has two internal reference voltages, which the driver
> > > > > currently
> > > > > doesn't make use of.
> > > > > 
> > > > > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding
> > > > > documentation for
> > > > > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > > > > <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > > 
> > > > >  .../devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml          | 4
> > > > >  ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > > b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > > index
> > > > > 63369ba388e4..879768af0303 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> > > > > 
> > > > > @@ -39,6 +39,9 @@ properties:
> > > > >    power-domains:
> > > > >      maxItems: 1
> > > > > 
> > > > > +  vref-supply:
> > > > > +    description: External ADC reference voltage supply on VREFH
> > > > > pad.
> > > > 
> > > > Please add it to the list of required properties, we can remove it as
> > > > soon as the driver has support for the internal reference voltages.
> > > 
> > > I was thinking in doing so before as well. But DT describes the
> > > hardware, and this ADC apparently would be functioning without a
> > > reference voltage on that pad, using a different one. What the driver
> > > actual does is a different matter.> 
> > I have also thought about it first but than I checked the RM which says
> > that "multi-reference selection" is chip dependent.

Nice for pointing this out. I wasn't aware that there are differences.

> Oh goody. So is it detectable?

That's my problem. I didn't find any source of information which chips do 
support multiple references and which don't.
Marco, do you have some information on this?

> If we are going to stick to a single compatible rather than adding them for
> the variants with and without this feature, should probably add a note at
> least to say it is required for some parts.

That's a good idea. I'm okay with that, until there is more information 
available.

Best regards
Alexander

> Also, link if public would be good for purposes of discussion as my google
> fu didn't find relevant doc. (assuming it's public)
> 
> 
> Jonathan
> 
> > Regards,
> > 
> >   Marco
> >   
> > > Best regards,
> > > Alexander
> > > 
> > > > Regards,
> > > > 
> > > >   Marco
> > > >   
> > > > > +
> > > > > 
> > > > >    "#io-channel-cells":
> > > > >      const: 1
> > > > > 
> > > > > @@ -72,6 +75,7 @@ examples:
> > > > >              assigned-clocks = <&clk IMX_SC_R_ADC_0>;
> > > > >              assigned-clock-rates = <24000000>;
> > > > >              power-domains = <&pd IMX_SC_R_ADC_0>;
> > > > > 
> > > > > +            vref-supply = <&reg_1v8>;
> > > > > 
> > > > >              #io-channel-cells = <1>;
> > > > >          
> > > > >          };
> > > > >      
> > > > >      };




