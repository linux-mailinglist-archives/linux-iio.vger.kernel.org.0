Return-Path: <linux-iio+bounces-27328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34933CD884D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7B1B30202D3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7D2FABE7;
	Tue, 23 Dec 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7/LHjAT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276730E0EC
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481161; cv=none; b=dS1j9OctNOlOQsZRJHiXKuYOE9B3XX+Ds1x0AgPOyOl/7vpvFm0QC6P1Dr03G/kZJ2Af14pulb3yD+BvoZWVnOnwPlMrltY6uLjXdULgIuuz5YeYq2Ky/PWZOqO68FJUh2mxRHddtRSF1qk8SAiwDRAzFSbI/X5n9ucAdiAcLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481161; c=relaxed/simple;
	bh=UD5kMgJDr4gyHdjVbkeA8ncPtEl/ZWoblEdUtUaX6Is=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aNW+WhHxXoAYD9sOei87cPSMn63aUYfKcyg4IF2GcmhP4IMv7MRUcYrUE4jTg7UUlXdYILNl50hMtWbl75BuR5tDiDWMOjfPsX0y4Zy4GxqZfwl4JTjC7MR7D+E4NaDoBgyZY/vbbc/jnS8HppBjwvtHX8KEfvmsyI/Qg5VmDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7/LHjAT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c708702dfso5037491a91.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 01:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766481159; x=1767085959; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUuy/PtZ9QhLtpMzGpl7OARqqSVWx7rYV1ajChEf4Dw=;
        b=X7/LHjATXyTLrjfLORu96poWfuLNNf4rLSLTgxoVWcCuM5tzKn5KSffEhJj8GnbyXY
         iWXnRRUzHDGd3xTfB45Mu11CbyQ6DjVoCiaktbCJCZYBTzQbU+yhfe62TVT2aUVfQkD3
         J98sFpquMWroonkPp/mZ5DZsWPy4xBAleWD2JgY3fSzDkH75OesMMaqGTz/ZnYAk5DZk
         XPzr8TeHjd51nV9PrdT6vw8WgrIisctLNO8MdIV0RryPFDveJB+pFbmey+nVwQsOZDFv
         fee+CAxnh+ewl1FC51lH3r6H3yDoBF5a283e04a/uFX+8gfhEUsCXE+9PscqQbXNsXzH
         8izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481159; x=1767085959;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUuy/PtZ9QhLtpMzGpl7OARqqSVWx7rYV1ajChEf4Dw=;
        b=rdi21RxlDEUvC4r1vVFYBZdPCBDCGiG8SykUqKW8+pP/qsIyQKndXmpFv224o4kJI/
         fyzUH61EKAx25WHTXHY6vGlf3MB4QdLFm5V1u7CKPTPF/44g9KfFmbA0RwkG40Gp4ZeJ
         dWDbofTtly4y3aGvxIO77QAgs4vPBxhKYAZ00pVG1BcuRMSMyCIAirUcHbRg0qLashB3
         3qbfMy3IGnbI2APTCOhjTUnWmw7M0CzQywp+8fodYHB33FBblddX3dEc1L+Prme44JZs
         RRlt8CDICH55IkFMNerskj2Vb2Wv2ACWdtmG1whrQlqoLYzQ39QLOaYJ/di88ewXp6Ig
         ya1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1qcNo2Ur0TV4njil2fx85FewZIHlybwFy+OFkNu/3ZACeq2wBjzhrwmBCvi0w1sqRActQl/xZvrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpWesGlzXANyNFsPzMary75gquXy+VLrVv2gXmv9FPH7cVVZX
	o0JnUyz8ce4zFljn5QEuNRRGDG2iX8+a6uYZi7CmNpx37gAg+R3ZBckV
X-Gm-Gg: AY/fxX4Ap0lCNF6ubYDLglu5OsW/yXf/To7GsdcekWyDieWYmlqsrNb49jaWezfuIXJ
	a03+GQTiBykerZRXufkppOL8rOgghy8eeQbm4dVAnhInVudEp1eSDmY+ytI4FWMnskkq5JBubaA
	3s/emEZ0UDRYQpsePRtpq3fYblwDnp99JapLBjynOuFrCKIM+nvJzTNs6FUDq3vV2Wmf0R+MYJA
	Qo/adAVE658Hnso4aWGpOnFxyX3CQYI6W8kBTQ3LsayWiUCbP4orkzfDY7N+uD4yxjnjQUKyp4D
	EVl3n6jYaeRx4fvDhYKDC+mF1I4YA13Fdj/6Gnc4byBMCtnGtoZAg2kFx8sqibS0T4MVztMbggX
	T6Fgwefg8oa4flku6D3OBnSVYLURGy2x30qQNWI0v2TPTkpmNvgjnmMuqCGXVJ9/RFXidn/TXUV
	/uChlLwTPDCIZMJ46brd8oy0Ynad/JDcGdt2Zp/YTQcLblsnkNMEc=
X-Google-Smtp-Source: AGHT+IFiEprMGVw5bVwvl2YWxliS1LVs29cxSUEufeoxyimAG5IT/zw84jdWnRlvhWMPBL7WBc6L4w==
X-Received: by 2002:a17:90b:2585:b0:341:8ac6:2244 with SMTP id 98e67ed59e1d1-34e9212a9fbmr11414669a91.9.1766481158643;
        Tue, 23 Dec 2025 01:12:38 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9224d9e5sm12352454a91.17.2025.12.23.01.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:12:38 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH 0/2] iio: adc: ltc2309: add support driver for ltc2305
Date: Tue, 23 Dec 2025 17:12:24 +0800
Message-Id: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhcSmkC/x3MSwqAMAwA0atI1hbaiN+riJTaRg2ISioiiHe3u
 HyLmQciCVOELntA6OLI+5Zg8gz84raZFIdkQI2lQSyUC8Gup8dClzYIXySqxmZyranM6GtI4SE
 08f1P++F9P8c7ZkdkAAAA
X-Change-ID: 20251223-add_ltc2305_driver-728fa9161bc7
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=727;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=UD5kMgJDr4gyHdjVbkeA8ncPtEl/ZWoblEdUtUaX6Is=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpSl0D7aN2D3pWAw5ItrHUjO/4cVTyJNKQxdAXP
 Xtq1MvVUZCJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUpdAwAKCRClg0K3CVbE
 gcxwB/915KWSF23U5iK3qDWl25B9lkrwVSorT3YucSe8ta6k/ukgfgE7kSwz+G3Xvd9Yc+BbjZ7
 ZNWN8rVZkcLfPa/L3WVsGLRLVhF33O6Q9ZUH4m53GXqlS5rBYC0y01nwEnJclbxKKvCEq/j0Vj8
 UY12+e0fTj2x4Dc0qfQVuH1uE6S96ekiL64bHDzp0pmJDTkWrLEybwMlaSPaVCThqvjw08cPbHq
 DuiYVRZifmh9WPFq5zD8P3Ke//RPl6CR0Q9CY45UaSTRJXtULAcsAm1VNU9y4nm5hajOj0MI/O+
 ddOXHzdFPVyE/3lHufOSlyLV6xZanZOfxCxAOzMB2K4rr/sa
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

The series add support for ltc2305 controller from 
Linear Technology Corporation(lltc).
This is low noise, low power, 2 channels 12-bit successive
approximation ADCs.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Kyle Hsieh (2):
      dt-bindings: adc: ltc2497: add support for ltc2305
      iio: adc: ltc2309: add support for ltc2305

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 +++
 drivers/iio/adc/ltc2309.c                          | 50 ++++++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-add_ltc2305_driver-728fa9161bc7

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


