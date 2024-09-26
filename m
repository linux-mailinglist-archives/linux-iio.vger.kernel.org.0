Return-Path: <linux-iio+bounces-9798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F092987740
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2101D1F28A67
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B149F158552;
	Thu, 26 Sep 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxezdJbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4716154BF8;
	Thu, 26 Sep 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366924; cv=none; b=TIpeZlyhVYyULxzJd0UQeDTdHJ4xfatPCadLj+C7Gzplq/5Xp4LB8c6TUWmJfVy+U4Ame0Qh+CZtVnOVUK3IA7w8cHeKATFAav8md9TECl2qf+uSvDbYj42X+r5WqAwSXle+YkvG5LGJyR82rwQvvlNceKY3yrWkGC6TOvw/mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366924; c=relaxed/simple;
	bh=1CI/fpmiMGMi1J3jURicxvginVm5OIwiTVw57yhg7jw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XU6UWPxMqSmbEDoYGBDb/ZZtG9NxmndW4B0bhJ/DPCDIHfu7Su2ISVw23cFy3IHLkGFAaZOWqVdwp/wC3pDJdcNQmJ1o44qwS2el8Xu0subjGfpBNDVDkzMZvyk2o3J/XE9vaXl0rjo5et5VWot8V3H7ONgt5L/iogYga9OrOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxezdJbD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso222543266b.1;
        Thu, 26 Sep 2024 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366920; x=1727971720; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gP+KVl3Nki9xP9jnHdY7npTezgVnfLdw1bgRUHESfM8=;
        b=WxezdJbDm4Ku/25IVLpiBuwOhVL0TNqkjwq8309ob5Z8yWkOFUHe0Fr8KK0N0RZIPn
         awY3IYxcGi87M1/nXtuA7qA0ESa0J0p0wavx9LVQ2xam15Yfb+n1lQwMJZqbYS4OlRM/
         ckfsSL91wgXpR6GntOo0t+ft/qYyNMUNNXFVHgUB03Krdgpn6IEiCEMWsyyBnMdNARHs
         YXwStHHNKI3CGwXSd3HmqTrLAQaajzWhfiNtO5TPo3rTLw0Nd6iNVDZqPmOLnlydPdDk
         nE5+pM7y9ZeVu9on0d4WHSJ5Is9r6uyCgM/aXTiMkPpRA/tUr2xBM/1m8WNRYTqI5lYg
         p+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366920; x=1727971720;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gP+KVl3Nki9xP9jnHdY7npTezgVnfLdw1bgRUHESfM8=;
        b=k/d5MbSLUwVh0xptwzPtW5MatOWv/Vcdhy6Mqha3cvBuH+k2Mh135XKAQzpERp2y6x
         LqghW8BQcC8ElOE7olL4i8X1zyFkJNz8n2EBPhHscjdwZ8EClR6584vl90ukL1EovKxv
         SM2XEZbk1sqnAWZ9VbxMZQuIsCQJAGbbhXhVxjmBw128RxYHkjt1TyT+MqM2KgibO0Z9
         82Uv7EOmxUFY+5t48wCDgOHN7rckhWoYn9G8sOFwJwOJ8YJZBYMYTCaM8rInjLnpegj2
         XRVg0yF3LP5hn+3wpgCqWS5RnWYJHZ5IwAO3FGWzpZC5sH5Gv87CbIZtyvCglYQKtZud
         AQIw==
X-Forwarded-Encrypted: i=1; AJvYcCVHkCzSUFOyb0sachbKJe2o1Wb9cv2r7MN7h9bAxjuBq0/LHG/q6cHpUTaZ9d8jvoBllOid0vkD4WLbsKNb@vger.kernel.org, AJvYcCWDUTUJXvPzbLsVe/BiyRFoNHvENQTmMZvZ/Qm1bVX0gNCKYgMf0BLHtFJdYaJy1GNxNYUFEQZQlzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVhIl81/Ost0LAK4II/ZskLHyQwNH1fKUFR1Oklt9RO62Nyfx
	Qv4UQnbQ3GzueigBZD7i0xTI0S6i0WUlEr2jk+olYA+I4kKbqv53gQbE0ZnV
X-Google-Smtp-Source: AGHT+IHJD6ELGXqZ1LcvJSbwjs53CX/iyOKOge9JOfylo2K10ErpdDcSnwB/LYDMcLoXoMRgMBLADg==
X-Received: by 2002:a17:907:36cd:b0:a7a:acae:340b with SMTP id a640c23a62f3a-a93c32119afmr42883666b.31.1727366919820;
        Thu, 26 Sep 2024 09:08:39 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6d88-4cd9-a9d4-f267.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d88:4cd9:a9d4:f267])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm13947966b.78.2024.09.26.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:08:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] iio: adc: use scoped device_for_each_childe_node()
Date: Thu, 26 Sep 2024 18:08:36 +0200
Message-Id: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASH9WYC/x2NXQqDMBAGryL73ICNP2CvUsqiu1+ahZJIAqUg3
 t3Qx4Fh5qCKYqj06A4q+Fq1nBrcbx1JXNMbzrQx+d6P/eJnZ5ZZmyjgkAtjlcgS7aOcsoKr5B3
 qZJuGEXOYdNmotfaCYL//5/k6zwvp/FZhdwAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727366918; l=1474;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1CI/fpmiMGMi1J3jURicxvginVm5OIwiTVw57yhg7jw=;
 b=9sbPl0gcd83nFbHGowD5FIQz+dLJhH94gn6DMUgsGRmoscq/J8Acvc+dh92pABpm6VnlTSEw+
 rKGP2hFhzmLAOHlJD6dEO29nVZ5b7zWDqDL/ztTqX/8J9DlWpX+pgIi
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The device_for_each_child_node() macro requires calls to
fwnode_handle_put() upon early exits (break/return), and that has been a
constant source of bugs in the kernel.

This series switches to the more secure, scoped version of the macro
in the IIO subsystem, wherever the loop contains error paths. This
change simplifies the code and removes the explicit calls to
fwnode_handle_put(). In all cases the child node is only used for
parsing, and not assigned to be used later.

The straightforward uses of the loop with no error paths have been left
untouched, as their simplicity justifies the non-scoped variant.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      iio: adc: qcom-pm8xxx-xoadc: use scoped device_for_each_child_node()
      iio: adc: qcom-spmi-vadc: use scoped device_for_each_child_node()
      iio: adc: sun20i-gpadc: use scoped device_for_each_child_node()
      iio: adc: ad5755: use scoped device_for_each_child_node()

 drivers/iio/adc/qcom-pm8xxx-xoadc.c |  8 +++-----
 drivers/iio/adc/qcom-spmi-vadc.c    |  7 ++-----
 drivers/iio/adc/sun20i-gpadc-iio.c  |  7 ++-----
 drivers/iio/dac/ad5755.c            | 11 +++--------
 4 files changed, 10 insertions(+), 23 deletions(-)
---
base-commit: 92fc9636d1471b7f68bfee70c776f7f77e747b97
change-id: 20240926-iio_device_for_each_child_node_scoped-cb534e6f5d9b

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


