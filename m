Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8F575CDC
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGOH4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiGOH4u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 03:56:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDD7E004;
        Fri, 15 Jul 2022 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1657871809; x=1689407809;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3e8PWl1SbKdPwB4I8T3+mrIuGshCyHGD0HiV7NPzQK8=;
  b=kwyVrUmkywiigit+xRfQCbMMsK4WkPpSqh1l23HcfLLN1MZus3x2K9Sg
   bDGkiWJjG2l44XoE0ApFTphQa2r/wPg3+/qpnDyOvhQk6nQ3suwJ0sL2B
   5/nxRMDzbsFdmX5btWaDiXyH9E3a/nlcjq4x/2SMBt6gzh/dz6NAV7RnB
   dEzdfi0SS0VDJpmlG912+TDzyBjOWkLVYKErX778ZxXdHf9++iqbDNZIF
   z3HYzOgv3HWqwca1q1KIYcOOOor2sqImWqTlC6pRXfsVKlz6nwrRJ16gy
   Npuu9bdxOP0xWh3jQI0T7zqF6OAaYEllwrJpgJ6V/rsZKekr+d+37g4gH
   w==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650924000"; 
   d="scan'208";a="25069308"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Jul 2022 09:56:46 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 15 Jul 2022 09:56:46 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 15 Jul 2022 09:56:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1657871806; x=1689407806;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=3e8PWl1SbKdPwB4I8T3+mrIuGshCyHGD0HiV7NPzQK8=;
  b=gXSpGuGkkqhUWE4ojoEh3e1qdmsFWUUqLWFijY+Qe9GK4eNmVZrOJN69
   fTBBummlErC9VH2Hi9dQoppZKC83CZ6eQLT0xYT/vZI4Q6ga0MBJTsE/V
   hl1QUnqovw5RUXXVjLnYb3UOAoK0dkYhzs0uRq/lwbgaNllJXO22MShYS
   qAYsLMzAnc2L3oChHPveveQuWieUKWL6/J1Qjht/m/fgZADr1gUyr2Oq5
   G87IyrX/h4nk6YlgaedgX8U5ajQP4C4sIfiBu0UsHVCLgBZMSZCyMakE0
   922ANdsw4qDLcTFh2WvNX4yQwvy97L4rJWW5sPevRenVENMEyEvry330n
   w==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650924000"; 
   d="scan'208";a="25069305"
Subject: Re: Re: [PATCH] dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Jul 2022 09:56:46 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 114F3280056;
        Fri, 15 Jul 2022 09:56:46 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org
Date:   Fri, 15 Jul 2022 09:56:45 +0200
Message-ID: <8090017.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220628210919.GB963202-robh@kernel.org>
References: <20220613123529.466528-1-alexander.stein@ew.tq-group.com> <12003373.O9o76ZdvQC@steina-w> <20220628210919.GB963202-robh@kernel.org>
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

Am Dienstag, 28. Juni 2022, 23:09:19 CEST schrieb Rob Herring:
> On Mon, Jun 20, 2022 at 10:12:44AM +0200, Alexander Stein wrote:
> > Hello,
> > 
> > Am Samstag, 18. Juni 2022, 19:01:29 CEST schrieb Jonathan Cameron:
> > > On Fri, 17 Jun 2022 16:44:48 -0600
> > > 
> > > Rob Herring <robh@kernel.org> wrote:
> > > > On Mon, Jun 13, 2022 at 11:34:46AM -0600, Rob Herring wrote:
> > > > > On Mon, 13 Jun 2022 14:35:29 +0200, Alexander Stein wrote:
> > > > > > Both are already using the vf610 compatible.
> > > > > > 
> > > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > > ---
> > > > > > 
> > > > > >  .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml       | 9
> > > > > >  ++++++++-
> > > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Running 'make dtbs_check' with the schema in this patch gives the
> > > > > following warnings. Consider if they are expected or the schema is
> > > > > incorrect. These may not be new warnings.
> > > > > 
> > > > > Note that it is not yet a requirement to have 0 warnings for
> > > > > dtbs_check.
> > > > > This will change in the future.
> > > > > 
> > > > > Full log is available here: https://patchwork.ozlabs.org/patch/
> > > > > 
> > > > > 
> > > > > adc@2198000: 'num-channels' does not match any of the regexes:
> > > > > 'pinctrl-[0-9]+'>
> > > > 
> > > > Looks like you need to add 'num-channels'?
> > > 
> > > or a lot of wrong dtbs :)
> > > 
> > > By which I mean ones providing a property that may or may not be
> > > actually
> > > used by any drivers...
> > 
> > This got already fixed by Baruch's patch which is currently in Shawn's
> > imx-
> > fixes-5.19 branch at [1]
> 
> Great!
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Did this got missed? Or is it applied somwhere I' not aware of?

Best regards,
Alexander



