Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BF5682DA3
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjAaNVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjAaNVG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:21:06 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE330D6;
        Tue, 31 Jan 2023 05:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675171230; x=1706707230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nc/B7599zo7bElrpIrWUHuDyejD6NgIG6t0wy6/MybE=;
  b=Iic9Nq3FqcbHMmHlsGIn2vqUpLrfBw+UQTEN5wvMuzdnQOyGTHFmYgKp
   IXe4xGhOaQmHuR5bccTIpLC/PulDLCMuwTpepZPvwacTlvTTm+YN1p8VP
   PQrm5Q4Adf4jfJKiJEcApqnHZzGiBX2q1OuGn9MiDaJbcKBSL3hoHR6dJ
   WRKgjzZkEQyos7dvesFhuHMZpohqnyV8Ua6j9EcAGjBoKDIwhQHX5yCA0
   236Cap42wm8iR4TkPUNAC1imbpD8QyICvKRXejw5T4F1rcweLS8ux1Sac
   yXnjKZrbFdJaktfHO5HessfFtDAEv1xH0lV9sGQGW1o5JQ7XWxcN/ceeT
   A==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28772469"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 14:20:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 14:20:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 14:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675171228; x=1706707228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nc/B7599zo7bElrpIrWUHuDyejD6NgIG6t0wy6/MybE=;
  b=ceFsbqQlwoOjz7MIYjiLq2Gk9tK+cqY+T1dnHOJYi1YXWuKQqYElFIC9
   lf1X7YhsOKhwvGw/KQOEFh5O/h7jON4aoztGbpkBEMd++oY6MhViaDqJU
   oQFPL98/bE7ypUGT4djChmBuJRC1AgldFRtLG56FRw5nTdk0TiDpM2Xmd
   syX0kv65ImH5jvDSBNIhpEP4BHN0sVZK7+PTLPJbqLFpFbEsW/ZuMqS2c
   Q1AKCIjGAtuNaHkMxzLgH4/mlm3hCY1duUnnBoG/AOG7PxTKHaHxfZzYF
   ogx3d2IWsXPJDVdQT5iaM7q/MYEy+1sjpIKtYCHbbKT0ZtcpuwJI8UZCJ
   g==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28772468"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 14:20:28 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 8870F280056;
        Tue, 31 Jan 2023 14:20:27 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add missing vref-supply
Date:   Tue, 31 Jan 2023 14:20:25 +0100
Message-ID: <13201978.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAOMZO5ArS_mx1PYs6QMjQS1CgG9XET6sbnWEuWo=Yrs084zYSA@mail.gmail.com>
References: <20230131101323.606931-1-alexander.stein@ew.tq-group.com> <CAOMZO5ArS_mx1PYs6QMjQS1CgG9XET6sbnWEuWo=Yrs084zYSA@mail.gmail.com>
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

Hi Fabio,

Am Dienstag, 31. Januar 2023, 13:16:11 CET schrieb Fabio Estevam:
> Hi Alexander,
> 
> On Tue, Jan 31, 2023 at 7:13 AM Alexander Stein
> 
> <alexander.stein@ew.tq-group.com> wrote:
> > Although this property is used right now for IIO_CHAN_INFO_SCALE,
> > this ADC has two internal reference voltages, which the driver currently
> > doesn't make use of.
> > 
> > Fixes: db73419d8c06 ("dt-bindings: iio: adc: Add binding documentation for
> > NXP IMX8QXP ADC") Signed-off-by: Alexander Stein
> > <alexander.stein@ew.tq-group.com>
> 
> In the Subject, it would be better to mention imx8qxp-adc.
> 
> dt-bindings: iio: imx8qxp-adc: add missing vref-supply

Nice, that's a good idea. Will change it.

Thanks and best regards,
Alexander


