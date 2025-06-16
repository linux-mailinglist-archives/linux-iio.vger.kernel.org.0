Return-Path: <linux-iio+bounces-20713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B0FADB2A1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AF51882E67
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861632EAD0E;
	Mon, 16 Jun 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RtBmYFvs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626A2877FC
	for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082050; cv=none; b=mwRv04OwOX0Bs4vHiUz59OnAI+Ehu1TX3ENw5370wnlhuOry5+UQnP5PGOtZ2brshj5GHNTEp298mGVCJhLPjMh830dhEcq4ilSjyqB0/zTuMmrxhE5Z0JSJ9KgjTicH6wr1sic0rNzNYS58BnczJeuRvpUPx8CLpdeDrCphCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082050; c=relaxed/simple;
	bh=WdYsA4gcGJ4whUTHaU62r1/1/AwXMOqpKKD02j5KM2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQeK0MpRJdokJXCI9LM1whdBWCaaO2cFBgJiIilAqEOF4hT0uX0MA1mNBUWcV0vXpQamEbsXpTzG0sAoAqamL4J7ZcngiBbIFo58PfIh6UPBrj8rtU7T/fq9ycVwvR1SXgZSJhk0FRHBO+CJ5cxCbxL3F5QDwXtCS0owKC1ix80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RtBmYFvs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so663877166b.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750082044; x=1750686844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJCI+6qwU3+gkjXsqHZde1TYEMyw88mnCNmjbKL5ih4=;
        b=RtBmYFvsW6Vw+ZL7FzFrE7wKDDtpCgAP3oBtY45llLJtfuIX5KB6kx+wl6KUVXW0wk
         AdjTflrSENkq8zVE1hn0C6SP7zMnPPh1FgAIiYI9Jranwe2S5LUJveuHvb2UrJYzH/eq
         ti2Lp0fuYXFr17hqjopDJRft1CSGHtXGdpyEIDoKKCYZP3FgOyha8/l3Z6oNimZ3doeP
         MBp12iEZovAIAA2B5T80taXplc7XWAnBMHZz8RWe49gY02aUOZBJ91mgYTftvKMFrQRu
         YvcI4G22TNevck4mSmfYTuwWsipLdgBLZBqy2PImcpD7i60AQA0wQ4lerrYyHpWIg39B
         Xa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082044; x=1750686844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJCI+6qwU3+gkjXsqHZde1TYEMyw88mnCNmjbKL5ih4=;
        b=wimPG5ZzST6nTxlAg9wH5DJmynuG2v09mvAcqiIj5U6Qf3lZPwWTHtQEQFlX+3eD6l
         LSLP+Yg4bNwYQw7YwEU/Q8i3FYnuMZTq/5Xmx+ojCmrT/9JpKKZizJzsjDbjif89Tf+4
         2iL6Nwkh4MiC1TOxGA7AeknYZipQGjVQa/Zr/nvpBuauSGOJzSVTxI9ySoBYVbwhHeD5
         wud/x0YVEVDQnOkyIaGLoj/DJPZEmib1G59eAW4cywuw6iZ0LvXumL4vJShvkwAzu2kN
         xfennaQGY5JkGVoQV0h2H/L2DD+cYCdNsrLBu2ZnRQqV6F7iHTZaKPRx4JOeaQ+uK5j9
         azLw==
X-Forwarded-Encrypted: i=1; AJvYcCV7irzrOJQajTPuFfwcO/6mVHcVtReV9DaI7H6wbkgYLSvMMNwN+2dcxI1AaAdTmYK2S3ynYbz8JvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTaNQGUR/+PMfDmIDRTn6tzu6LvYcSxYQWrv4XJXS2nrMmpRQ
	gpLgYXeEaa/fh77u0mP10A1yyjnitu7u1+WeuxQRCLwt0VUiA84go9ZvhrChPjEOpp0=
X-Gm-Gg: ASbGnctDL8lZH8vLTsRrM7vNrQJF46vKiAI8SdPZugAowyqoBQAdTg90KlbaDdYYvQ5
	zQp4Q/IA2NW8Yla1TSFd85kZ8rdjer8WwS6PqlMLXohMf2UC2rHklYfXW3b/+LtLGwwGE6CxcqY
	IO99OMBd9/DlWSMwSEm573aMFOCSm0i02QZhqkL9SkdmsmKHS2jWjxO9F7q4UBw8kryl+I53hKz
	tPOg4lr8rmEe4csZOgnfStP2b+uX4BS0/2syq3WSidZkkKYUxUw2T9lyeNB+WJlDAOgCwFNWx1h
	//CeoUtCGeKhYzVP/2F64Bk4KuA+RbYvlOX0QGCX+eCy76KJCzkKcoh41nKM9Jd3d9fzXsKCix/
	VqMnJyZShTz0n9ySd
X-Google-Smtp-Source: AGHT+IFIEkskkJG9WLW+Hv9ZKWW2DbdD0zYs82b6WVAC9yGzm6OdzcpBZetxbCKgKVtLW2Au71dzLw==
X-Received: by 2002:a17:906:c14c:b0:ade:484d:1518 with SMTP id a640c23a62f3a-adfad38b235mr948743466b.26.1750082044401;
        Mon, 16 Jun 2025 06:54:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec897a70bsm662748966b.154.2025.06.16.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/2] PM: domains: Detach on device_unbind_cleanup()
Date: Mon, 16 Jun 2025 16:53:55 +0300
Message-ID: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series drops the dev_pm_domain_detach() from platform bus remove and
adds it in device_unbind_cleanup() to avoid runtime resumming the device
after it was detached from its PM domain.

Please provide your feedback.

Thank you,
Claudiu

Changes in v4:
- added a flag in dev_pm_info that is saved in dev_pm_domain_attach()
  and used in device_unbind_cleanup()

Changes in v3:
- add devm_pm_domain_attach()

Changes in v2:
- dropped the devres group open/close approach and use
  devm_pm_domain_attach()
- adjusted patch description to reflect the new approach

Claudiu Beznea (2):
  PM: domains: Add domain detach_power_off state
  driver core: platform: Drop dev_pm_domain_detach()

 drivers/base/dd.c           | 2 ++
 drivers/base/platform.c     | 6 +-----
 drivers/base/power/common.c | 3 +++
 include/linux/pm.h          | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.0


