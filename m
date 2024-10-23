Return-Path: <linux-iio+bounces-11012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8EB9AD461
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A11C22061
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E771D07AA;
	Wed, 23 Oct 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8wMIeuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C1D1756;
	Wed, 23 Oct 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710004; cv=none; b=QTKicS0Q/taumWLbCLrUFlq0OOCgP3CxUPdVPiAOnhPbVtzd8evQnfpzuiU7S7QmkpB12zLmv9QHNqNpK1LcDbOmHJtYtiK4BJaJ1QzDoSB/y6LZxkhb2C0uiJKr0UQ+JQLnisSwlprxEFKU6JQugVwFjppXnbG/R5Rx4OwQQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710004; c=relaxed/simple;
	bh=3ySqNRLtGWwpMyBHGSdChNcqITgkUEvbM2RBlgIaxds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=evK2lHwhKR6ucDjtivdDqothVBMkQQJFt7kTfOVc6mUJbkuOCSP4vOjg9V1J5Fb2LIxDCxcY5KtYlqO9LfpCkVE3U8/oMH1OWA+mS++aXjToypqYQPpmTBb7VYPkGuWo4g/oyGGM7j1JFKh2wZzGwTFs2JUvZn3nMF0217eEMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8wMIeuj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so1099535e9.1;
        Wed, 23 Oct 2024 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710001; x=1730314801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsJIF8FT1ZOAASevldtxcNuDKIhD6kU5J03bohqg87A=;
        b=D8wMIeujxkK45xkZlhTckS8z/IGvl0mifSFRSfvdMU/XG3LvKQDtIkAONueyUwoCUB
         ffERTNa81l1vaaJR5UTmq+YW1x13a/bzepOl0S6UlIi3rnPp2vgdJ6XuIPz1Y5iTO1n5
         HPj/eetfe5YlN9pdfcds3Z1fGhhQeHgBZnYXvH0XPd43j6G6qwQOjbAEDBwu9as4G7/e
         Szrt0jBEroXoz8SVr3JJc+eKWj+r8w14BZ5z/eHB++N/0Ykc5DGHGW/34D5ehNvbCoSB
         cGj/t+lrO+fp7Q+4MYu9woL/CLUlphwypSTVyMla2oOMqXIQxbDsG//ilsiu2ABiBVye
         hPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710001; x=1730314801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsJIF8FT1ZOAASevldtxcNuDKIhD6kU5J03bohqg87A=;
        b=rjIjoc5NYIs4yvXwchwmSZOeyE5IEbjCEIkoNFhMo7lKju5UB1IbQui3ETgoUily7S
         jJ+2Ezl4dFtfZ0SuIyLZePHNF2Nrs/3OXLxbo5Psqt2ZI47arXx3orR9duJCePPk2Si9
         snTRXwiz4RxJ1+K97DRhw/FpBxJPborsUxI6RqERUEo9mR/fFiv26/eve2ObazerEe7n
         +NBa6oPcGHJVux6s5Gbh3kLt0ePlXC+2+L2mOYbuDde4BIAeB6IwDTJluupUyum4Aa5v
         jx0u8hTMg9zFvQWaGimiBshvtpRO4ocv3fRDJGfRPvgqVPwTzyFfZ/ULhI+wIAxZ4chU
         NcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBAF+6Cq88yOcXD1f5ACeBWYsHFGnt5Ae5k87LintPQVqKS34+9Qd/grGNoEjO/ZfEbxCHfEbSKr6jSHi@vger.kernel.org, AJvYcCViPrjEqv7B2vgp9oul/+JtMSbq4AJkWQg1th+dheyye2uS8XxSE4tpZ6LEYtOqRkSlv+zOjjlolAv7@vger.kernel.org
X-Gm-Message-State: AOJu0YycYEdUSDKi3FIa7qLr2mg9VXdyaSjwOsFpWeIajoCKZ7SQW8YP
	jEI5o2etfCyxNJmFjtG5DARIdxjp3i+bg4V6gBYHCJKwbMTg5D1j
X-Google-Smtp-Source: AGHT+IFTs7ItDseyR4ZDl5HA79aGpVYcUk5tq1heIhbRH/wK064InmWoKT1MOInjiCQD2tlVX/SA5w==
X-Received: by 2002:a05:600c:19d4:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-4318412ff0dmr29920895e9.2.1729710001082;
        Wed, 23 Oct 2024 12:00:01 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7f1-415d-4bfe-cca9.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7f1:415d:4bfe:cca9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a707sm24176485e9.33.2024.10.23.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:00:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/2] iio: light: add support for veml3235
Date: Wed, 23 Oct 2024 20:59:57 +0200
Message-Id: <20241023-veml3235-v3-0-8490f2622f9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK1HGWcC/02MywrDIBBFfyW4rmUc8+yq/1G6UDMmQl5okZaQf
 68JhWZ5LveclQXyjgK7ZSvzFF1w85RAXjJmejV1xF2bmCFgLgAqHmkcJMqCg5I1lgU1WhFL98W
 Tde8j9Xgm7l14zf5zlKPY119ElP9IFBy4biC3NWCryN67UbnhauaR7ZGIJxHhJGISc20qY1VbE
 eizuG3bF3pciwfZAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729709999; l=2472;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3ySqNRLtGWwpMyBHGSdChNcqITgkUEvbM2RBlgIaxds=;
 b=p6sGnY5rJllCmR1IedzW0iJxFWX3QqmzzOH5UDSp8n45HCsJLaD8Q5OkHGjcisqUZF5/fPU0m
 EHf7+bc5yzqBzqEBNRvkE6sfo1TwnxFLuQVvycCSjhaOirfSlUdfHQh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds support for the Vishay veml3235 ambient light sensor
with I2C protocol interface.

I attempted to add support for this device in the existing veml6030
driver, as it shares some operating principles with the supported
devices. But given that the veml3235 has different register addresses,
bit arrangements, and limited functionality, it ended up making most of
the driver kind of device-agnostic.

Instead, the proposed driver is based on the recently updated veml6030
with multiple simplifications and a few clean ups (e.g. regfields,
right definition of shared-by-all info masks, which can't be modified
in veml6030 as it breaks the ABI).

On the other hand, the dt-bindings can be recycled as there is no real
reason to add new ones. From a dt-bindings point of view it resembles
the already supported veml7700. But if for whatever reason new bindings
would be preferred, I am willing to provide them in further versions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Add missing Tag to [1/2] (Acked-by).
- Drop processed values from the driver, which in turn removes the need
  to store the current resolution, gain and integration time in the
  driver data.
- Fix SD0 bit position (15).
- Drop redundant configuration write in hw_init (gain and integration
  times are the only fields to set).
- Link to v2: https://lore.kernel.org/r/20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com

Changes in v2:
- Rename SD/SD0 bits to include register name.
- Switch to dev_info() when checking ID.
- Simplify val/val2 handling in veml3235_set_gain().
- Move return -EINVAL to the default case in veml3235_read_avail().
- Link to v1: https://lore.kernel.org/r/20241016-veml3235-v1-0-b904f802daef@gmail.com

---
Javier Carrasco (2):
      dt-bindings: iio: light: veml6030: add veml3235
      iio: light: add support for veml3235

 .../bindings/iio/light/vishay,veml6030.yaml        |   5 +-
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml3235.c                       | 504 +++++++++++++++++++++
 5 files changed, 526 insertions(+), 1 deletion(-)
---
base-commit: ceab669fdf7b7510b4e4997b33d6f66e433a96db
change-id: 20241007-veml3235-0a38265e9bae

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


