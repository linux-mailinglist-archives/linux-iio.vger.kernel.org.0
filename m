Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC968BC1E
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 12:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFLy5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 06:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFLyy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 06:54:54 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B61448A;
        Mon,  6 Feb 2023 03:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675684493; x=1707220493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lis3l5zmiwseEfKMd6n3wB7+kL79DdnDESv5iBtuvlg=;
  b=ldfHT85lb4fvGa/cnacFMyc1FZUUvpGIyUQTN6EC+eUT9noi5/fKHB7/
   M5BZITaxG4QwH4IkewLz7++qSTVrhanv78jxmydo0VKeg0QVTPyTGCZ+e
   lqfIg2GT94tsr46HvtvVl0bgBuo5iyruFJeSqNsG6z6YkpkfDnU9/8aky
   7RYsY4p6a/OrrBN3sv2MGDRAgFdQt/Tyzk24uRmnFiFJAZ912oNxsJDVK
   W+MvtvdH73XOYVJwy0opLXAg//f/KkcGGDJrQlrOFRLhhhERPnTXvzPnl
   lHnXt01zPsHDISLDoSouPJNWimxMmI+3JO1OnRdRkX3mDZP3T0ieMBHDl
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669071600"; 
   d="scan'208";a="28889043"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Feb 2023 12:54:50 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 06 Feb 2023 12:54:51 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 06 Feb 2023 12:54:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675684491; x=1707220491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lis3l5zmiwseEfKMd6n3wB7+kL79DdnDESv5iBtuvlg=;
  b=Ivw1UsC6U+znm/d+OjC/oOSKWApTkwhBHF1Xa9Q0GZbwzZvRxKETlPR3
   3XbPZ1QtgZ6to+9Z8zv7iPic61Mm2Db5RNFshLwAXepbBmPC7bVm3uy2t
   YkRI7c9ItiBljzN7yphSDXuNFP8U1X8gDX8/L8JuvD+7KDBwNHN7p42pz
   861xbQjgFIZAuguTxaZwFzwRWKpUZTZWZBzbM236pBMxHki/TnCVlL1e6
   ZPT/fNDSf4OVnOHRNrEudZkahKLDnQOUJ/jBFWDEpEfrwxUosWVBKN6iG
   NfuPhuPhyiM1Z80X9Tr067xeUgTdjN+uSV/WE9hpTtSCKmleUxfqlm26U
   A==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669071600"; 
   d="scan'208";a="28889041"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Feb 2023 12:54:50 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 41641280056;
        Mon,  6 Feb 2023 12:54:50 +0100 (CET)
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
Date:   Mon, 06 Feb 2023 12:54:47 +0100
Message-ID: <3215933.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230204001333.ywrkty3an3cbuq33@pengutronix.de>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com> <3214924.aeNJFYEL58@steina-w> <20230204001333.ywrkty3an3cbuq33@pengutronix.de>
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

Hi Marco,

Am Samstag, 4. Februar 2023, 01:13:33 CET schrieb Marco Felsch:
> HI Alexander,
> 
> On 23-02-03, Alexander Stein wrote:
> > Am Freitag, 3. Februar 2023, 15:12:17 CET schrieb Marco Felsch:
> > > Hi,
> > > 
> > > On 23-02-03, Alexander Stein wrote:
> > > 
> > > ...
> > > 
> > > > > > > > > +  vref-supply:
> > > > > > > > > +    description: External ADC reference voltage supply on
> > > > > > > > > VREFH
> > > > > > > > > pad.
> > > > > > > > 
> > > > > > > > Please add it to the list of required properties, we can
> > > > > > > > remove it
> > > > > > > > as
> > > > > > > > soon as the driver has support for the internal reference
> > > > > > > > voltages.
> > > > > > > 
> > > > > > > I was thinking in doing so before as well. But DT describes the
> > > > > > > hardware, and this ADC apparently would be functioning without a
> > > > > > > reference voltage on that pad, using a different one. What the
> > > > > > > driver
> > > > > > > actual does is a different matter.>
> > > > > > 
> > > > > > I have also thought about it first but than I checked the RM which
> > > > > > says
> > > > > > that "multi-reference selection" is chip dependent.
> > > > 
> > > > Nice for pointing this out. I wasn't aware that there are differences.
> > > > 
> > > > > Oh goody. So is it detectable?
> > > > 
> > > > That's my problem. I didn't find any source of information which chips
> > > > do
> > > > support multiple references and which don't.
> > > > Marco, do you have some information on this?
> > > 
> > > You can download the RM from the NXP website but you need an account for
> > > it:
> > > https://www.nxp.com/products/processors-and-microcontrollers/arm-process
> > > ors/
> > > i-mx-applications-processors/i-mx-8-applications-processors/i-mx-8-fami
> > > ly-ar
> > > m-cortex-a53-cortex-a72-virtualization-vision-3d-graphics-4k-video:i.MX
> > > 8
> > > 
> > > Or is this the wrong model? The naming scheme is quite confusing to me.
> > 
> > That's i.MX8 (imx8qm), the bindings are for i.MX8X (imx8qxp/imx8dxp). But
> > I
> > assume the ADC is similar/identical.
> > 
> > > > > If we are going to stick to a single compatible rather than adding
> > > > > them
> > > > > for
> > > > > the variants with and without this feature, should probably add a
> > > > > note
> > > > > at
> > > > > least to say it is required for some parts.
> > > > 
> > > > That's a good idea. I'm okay with that, until there is more
> > > > information
> > > > available.
> > > 
> > > According the RM there is a bit which can be read: Multi Vref
> > > Implemented (MVI).
> > 
> > Ah, nice. So there is a hardware feature. From the RM I have available it
> > is set for both imx8qm and imx8qxp. Given that I will not mark this as
> > required, but add a comment regarding this feature bit.
> 
> Can you check the comments about the refsel please? Since this is the
> important part.  Since the RM above states that this bit will indicate a
> multiref device but it can also the case that, you have a chip with just
> on ref selection option (external). I can't check this since I don't
> have the RM for this. @NXP can you give us more information please?

I would assume if MVI is 0 REFSEL should be considered reserved.
Both imx8qm and imx8qxp have MVI set, even imx1170 has this bit set. So I am 
not aware of any SoC with MVI not being set.

Best regards,
Alexander



