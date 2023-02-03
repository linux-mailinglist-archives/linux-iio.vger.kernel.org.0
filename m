Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA2689B7A
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCOVL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 09:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBCOVJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 09:21:09 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC59113CB;
        Fri,  3 Feb 2023 06:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675434044; x=1706970044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nry1T94df9OQlSpOX/lRpiFLZljoy07EtiJ/B+IqtPI=;
  b=LCVXp8H3dmWAvo9+5zNYclg+ZvXjOwb36E5VFLu3Yupt/9x5G14IVhpM
   tU7mdltXPoeMblmq0egkaa0Ct2S2YK1uNtqoU1j72+cZ2B/fhreER0Nz6
   YFOC34Oy1QsA0lzN4UvGG2MIxOMefBvhRTND8X0AUzjR6D0K6uVd+x08V
   sL0T2AadarJuL8H7NTZNN3qeBa/QpXdKawZdgahSmKQQt+n2BQAAlq/Bt
   NWF4kcmKwO53DJQEMLvVdXMYPtqKXUrZZG6xgGulVUF1Rn1B19eJuf7H7
   1fCil9j5SoZrfDYuxaxb+TNStuHpbFIUt5YHNo3ic4a4K/eEWftb3Lw1B
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669071600"; 
   d="scan'208";a="28858447"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Feb 2023 15:20:42 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 03 Feb 2023 15:20:42 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 03 Feb 2023 15:20:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675434042; x=1706970042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nry1T94df9OQlSpOX/lRpiFLZljoy07EtiJ/B+IqtPI=;
  b=Ue9oICqZ9cyvuPmumaZY4OzHIL1voMqd5YHRlRKyh7ZetB7Q/k0ai7ui
   c9FH5Wmb/zppmRIMJQrtLgCpBCmz5JWBbIdivvZK4r2+CfIZbEGauP3aL
   5LaudZRO14/Za+tlWdqSOmvWKWpjEdiWCSVuGAgrU8moY8eIgrO6/MDbx
   PQaNjACUtMV06G3DDvv4zd3rW92zFvTM8ED1cFSdAuodq/aDYsRixvRSF
   YpqdXP1qLZfvpPJhn5a6VJUMy7kPG/Z+7I7yehU8LQ9xsms0VC6WxhaE4
   0AgSRvLWkwZuyIowZLzw9RYMB/rJOsLBPiBApx/dePR2aX4x8KF9sRMd3
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669071600"; 
   d="scan'208";a="28858446"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Feb 2023 15:20:41 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 81E7C280072;
        Fri,  3 Feb 2023 15:20:41 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
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
Date:   Fri, 03 Feb 2023 15:20:41 +0100
Message-ID: <3214924.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230203141217.et55oxbtxcilg3ig@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com> <1922814.PYKUYFuaPT@steina-w> <20230203141217.et55oxbtxcilg3ig@pengutronix.de>
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

Am Freitag, 3. Februar 2023, 15:12:17 CET schrieb Marco Felsch:
> Hi,
> 
> On 23-02-03, Alexander Stein wrote:
> 
> ...
> 
> > > > > > > +  vref-supply:
> > > > > > > +    description: External ADC reference voltage supply on VREFH
> > > > > > > pad.
> > > > > > 
> > > > > > Please add it to the list of required properties, we can remove it
> > > > > > as
> > > > > > soon as the driver has support for the internal reference
> > > > > > voltages.
> > > > > 
> > > > > I was thinking in doing so before as well. But DT describes the
> > > > > hardware, and this ADC apparently would be functioning without a
> > > > > reference voltage on that pad, using a different one. What the
> > > > > driver
> > > > > actual does is a different matter.>
> > > > 
> > > > I have also thought about it first but than I checked the RM which
> > > > says
> > > > that "multi-reference selection" is chip dependent.
> > 
> > Nice for pointing this out. I wasn't aware that there are differences.
> > 
> > > Oh goody. So is it detectable?
> > 
> > That's my problem. I didn't find any source of information which chips do
> > support multiple references and which don't.
> > Marco, do you have some information on this?
> 
> You can download the RM from the NXP website but you need an account for
> it:
> https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/
> i-mx-applications-processors/i-mx-8-applications-processors/i-mx-8-family-ar
> m-cortex-a53-cortex-a72-virtualization-vision-3d-graphics-4k-video:i.MX8
> 
> Or is this the wrong model? The naming scheme is quite confusing to me.

That's i.MX8 (imx8qm), the bindings are for i.MX8X (imx8qxp/imx8dxp). But I 
assume the ADC is similar/identical.

> > > If we are going to stick to a single compatible rather than adding them
> > > for
> > > the variants with and without this feature, should probably add a note
> > > at
> > > least to say it is required for some parts.
> > 
> > That's a good idea. I'm okay with that, until there is more information
> > available.
> 
> According the RM there is a bit which can be read: Multi Vref
> Implemented (MVI).

Ah, nice. So there is a hardware feature. From the RM I have available it is 
set for both imx8qm and imx8qxp. Given that I will not mark this as required, 
but add a comment regarding this feature bit.

Best regards,
Alexander

> Regards,
>   Marco




