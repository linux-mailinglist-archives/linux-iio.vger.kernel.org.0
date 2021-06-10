Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA43A2B6E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFJM0T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:19 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.174]:18874 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhFJM0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327848; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VnY+r169OFGSFRHtxpraf/HCOWLfhCuNYOLSdOnNMb5+fzQbbvNeHRHSjiSzWLhFI9
    xnqe9mbi8+GcO5xoOXzMqGLP+AmL+qKVU24sa4+DCurzhhvk5JO7LyXfSL91hs2WIfxs
    5oFbNUunWldRgn1x/oyI6qDAouJCVVsOTfPHHxUCbRrje2rCWHGAYELXe6+1kRnY62lj
    v5gwnyjdghaNLopUtDxXu3yWLiBY/VHWLCifOQ7YQjMj/NNoEOrscIlMmTaCA6UO9tiC
    jXV9P7MY4ZsxscnTf1Lp5HiO9y187GQR6TN0k4+XgXhLVuqfoSt3w7TqimGZAz0hJ6yK
    5clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327848;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mzhlFtT0uPEpgxtGsCZLk5RpPAfjBTETW3jiAJ+alHo=;
    b=bAS2uc9Mf/zP/m4kWJqYZ+ZJ2/sa6ZTe2VbE0xmxjPEVLa66p1/b/HEG61A/sJF1Nq
    v35/v/WfMxIoLXoZi7Zp5ZB7kCJgyM9uINz5xcqB/PR5vWl9T46YkP71y5O1HglpnKh5
    W0JJipULwMdIdZhbVEwnRi0q9eQU1edov1B8GGgHNpW1ygRuUV8kMGHQ9GMG+jElMuU7
    dQSXTAYOTV0hQuMCvp3iDvNjXcwmPnsjxT+jeL3Ltn+NuLHcNH1I3/I2ih1XwKRjOuLA
    6BASKphgqIFI+poXk2zzl4TOXW9rJBq2QMLnovAIFdQFYxVm+dXjNmZFZzAE4l3uddfZ
    fZDg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327848;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mzhlFtT0uPEpgxtGsCZLk5RpPAfjBTETW3jiAJ+alHo=;
    b=XM7rBGd7ssFaduYITxxTvJfWla/kj2zyLs9Zcddm+dJKgCRe8G6ovb8Gwe155U8yTN
    HF1FdARiXA6Uo/IV8ci3rpne1r8qbBbC8phJU9ZrjrsaRA2ZaQbEiHMUZM0Gzx3ERxfB
    1R/3d/EuFTXCgWGjndVTAMUOMb2TIOtj/SUDlTW4au8VMqJRaye7yvFRfywVliH5s+id
    hCvVYdykRSw9e0qB8TAHzb/oqk1rUyfy/BqgFVBDG2CbyVYDVS6uqkb0X0TabqVv/dHC
    VcEenO3Rz+qheF/Z/sHdxREd758ZqRTybC6MAAMyhyyk0vtf00I6hzyhgEYUg6L5wqqP
    YiLA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO8tzx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:08 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 5/9] dt-bindings: iio: accel: bma255: Document bosch,bma253
Date:   Thu, 10 Jun 2021 14:21:22 +0200
Message-Id: <20210610122126.50504-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610122126.50504-1-stephan@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMA253 is mostly like BMA255 that is already supported by the
bmc150-accel driver. Document an extra bosch,bma253 compatible for it.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c2efbb813ca2..8afb0fe8ef5c 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - bosch,bmc150_accel
       - bosch,bmi055_accel
+      - bosch,bma253
       - bosch,bma255
       - bosch,bma250e
       - bosch,bma222
-- 
2.32.0

