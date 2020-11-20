Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4469C2BB392
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgKTSgV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 13:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730741AbgKTSgU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Nov 2020 13:36:20 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EE324124;
        Fri, 20 Nov 2020 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897380;
        bh=ztkRCbtkWtGvXLSbnQZrK/THzmiKGv5SeG3+LBnao+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYZodTvXJ+dp0sqeNrDUx46LbwGzRhKJpFFP5UYT18FXl7tJzDnPqQym2/bWMIE8P
         HFymR6+nhFKmJFgGUvYdGfq/esohnAIcV8jqsRn/7Rbsge8cUqOdWZkZ33nkz8516E
         jibmexJ8QdzylVLK/jissYTJ1ASWQIjF3vbZMEr0=
Date:   Fri, 20 Nov 2020 12:36:26 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 090/141] iio: adc: cpcap: Fix fall-through warnings for Clang
Message-ID: <b3c1c3f9c76f2f0e832f956587f227e44af57d3d.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iio/adc/cpcap-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 64c3cc382311..f19c9aa93f17 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -557,6 +557,7 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
 		break;
 	case CPCAP_ADC_BATTP_PI16 ... CPCAP_ADC_BATTI_PI17:
 		value1 |= CPCAP_BIT_RAND1;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

