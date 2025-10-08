Return-Path: <linux-iio+bounces-24860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E9BC614B
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF24F4EB438
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A742ECE87;
	Wed,  8 Oct 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="WxPe1G5J"
X-Original-To: linux-iio@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5825FA2D;
	Wed,  8 Oct 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942387; cv=pass; b=O9uCYbva6MyElkZwVeTDt2qyhVbH56EY99rZRsjTiyHDJe2/uzE5sPijfI7V5u5zT8Xsji1IhYbjt5pmel6RzTdwNLr7vis8wtp+AjAS4DUgTeuuBcjvWyKqAcdKyl1uwLk/hmX2VffISC17jBFGQq9DAka+43QLOgUeppfaVDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942387; c=relaxed/simple;
	bh=QyVLaqRu1FWY88UCmuWbyDOaik5JVVVKJn0zpgG2U1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gHdeNBUNteaqDdeiG1JoZvRpmG38KKcWU9TkJlwlVDdYga3t79urRRNIajNyo0vMi4V8B2XFLPQFrGCeub51Cxpl4EMFby/13BJcfMf++3kDtzj278SmfAuft+a8aoRNV1jIvoix1cGIBSggBmr4vV6iehbpWU0L4wNF3nJBouA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=WxPe1G5J; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from homelab ([58.82.196.128])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 598GpsnR2103175
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 00:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1759942325; cv=none;
	b=sLgBefLwQLI26pZPfzu5Ls7dGY0JA+2XMh9dYtn7nM4oNooUGNkjm1ZGY6eaIOgzPJTxzwO6K4XHQD2Lcunn6Q0dfj3ZZPkADGAVIaLfWR0wYKnc0cI6qwafXbCy2E6j2Dw6ZGAUap3ipHj6Ycb+zII8cHj1/w5jFcTDgTsseDU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1759942325; c=relaxed/relaxed;
	bh=CHqaJ4PRUSilEEuBUhPDMPm/tElwzkSvosfNFVDPAgk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=y2wBmouT+KpS+s7l0jA7LWALt6lUL0YShTpAFi1D3bQ44FZA2PJD1+MSWgRxf+qF1T4JDI4k4ajXn73FlY2NSKJxLwPIw2pRPKc+DKxGnu3qakscf60trSolBuWKXkOP/5cjDTlk+m1sBJPZvuGo/b/waciIwQVzGYvSwJdm6I8=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1759942325;
	bh=CHqaJ4PRUSilEEuBUhPDMPm/tElwzkSvosfNFVDPAgk=;
	h=Date:From:To:Cc:Subject:From;
	b=WxPe1G5JaciuAHoqFZVV1F4w/H+S1CRG8XwUhXA8fQ+yDN20ddbt0G98rlIpAS0M3
	 41TW/YHiB9e8K6bUcXrGv+2YqcTXVBnWIoGQjKoRvVcu41UbBMftGGdC6BxPJC5B1r
	 RtGwPbnIKwdu6lAYfzODKv+yXfbvucmcNBMY2FBg=
Date: Thu, 9 Oct 2025 00:51:49 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Fix pm runtime clean-up in sun4i_gpadc_probe
Message-ID: <aOaWpVGZSCY6kN-6@homelab>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In `sun4i_gpadc_probe`, in case of thermal register failure, the runtime
PM usage counter would not be decreased, resulting in a possible
inconsistency of runtime PM state.

Fixes: b0a242894f11 ("iio: adc: sun4i-gpadc-iio: register in the thermal after registering in pm")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 6b8d6bee1873..ae4a59a965b9 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -644,7 +644,8 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
+			ret = PTR_ERR(info->tzd);
+			goto err_map;
 		}
 	}
 
-- 
2.39.5


