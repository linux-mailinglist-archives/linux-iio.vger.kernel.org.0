Return-Path: <linux-iio+bounces-18752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED2A9E893
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BF0174FEE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E11D5143;
	Mon, 28 Apr 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpFdPQgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CA610C;
	Mon, 28 Apr 2025 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823280; cv=none; b=nViga8FTCpeN7bW8lvaKvbWSgqkIkcKyQmcwRGs4eqRzVrl4KmFGPFuCQi86QrJX+NkslSEaOdVquylgHAuyiR+7tbuEuBrcKByAkBdwDSl8mEmTz6t3nrKwm9Af0AOsbnsk3EGG8bWv3Rt2gEmUnNuZ5XyPaMtbokDfmu/akBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823280; c=relaxed/simple;
	bh=48cNU57hP+b9UkBTib/Cvujad4ba1JubYtk40ZfdEz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P7dAOxGqbPLymP5Pps9M5WlcZvyFURlJuyXtS7FDIUWIvu3yGiwhDnMmNm/anrQkSwe1bDE9XHuR4l6zx+w9sO3EE+n+ijOSAtfxRworv0ALxtiKWX6xkIvPUr/lTFz3YfG9ee5JvBg11ey8sdf1IPQwYPIcIVTLVFDL8Py/mcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpFdPQgS; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54addb5a139so4779800e87.0;
        Sun, 27 Apr 2025 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823277; x=1746428077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSekJLgCgUpPHCoaul8BTpjij5Bz3zhv9bJ5xoXvV60=;
        b=JpFdPQgSKsNmcrytl1gyrhVY2cPKvfpAxfmdxmdIj1lndD0WghUOuxqJElf+LVSBw9
         /uskrUgnL7ctcUwKbzexZSO0NNsBf94E5OMWI9hocMJBa5w539ifnehBYDtpbRy9kM2i
         On+lvqLap7oQ7QyU2jaAv1N2LFbQBu7HlHDwKMj5kv/aqgIse+hp0UN6Nu7s3FVZqIVr
         LKux2swJ+fV7qLeEbXRmMf+K0cfWZUxB6BL9Yg+DuwxWZDU3/p+sFpCtNaS+366y13Ay
         suVkB74MwAMNCbqsZXK8Lei/NqnDB0HEiN3CTr3ZlZ2vrlMwZrQQmkUwr+7O1JOHrDmV
         CqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823277; x=1746428077;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSekJLgCgUpPHCoaul8BTpjij5Bz3zhv9bJ5xoXvV60=;
        b=i1sQVPZ9SlHbUIyaXTB4t+/veC0VdrlHN9Q4Ll8wqkxzJ/o/tEWjQ0pH+vNDN9lJzu
         4gbFTvQAAGmjLbhEM1rM3/gpusQB1jMy6CTKLJtBIJx2vfS2WZrsFFce+DdF0gEdY41K
         Vr0ynmANgF1xk601v7QfUafzNVMdf4utUU1eTz1fa7Tz6caKhyn2OxzZbEPWxwXf7qPE
         nMrubD4g+JpOqvmZR2L153+GimYy8Jz66zEvT2vZR4BiWM9/f9QGa5E/fOLr1vXsMo8k
         3sO72gTeNN5ovV0wlAFNzeZbJC4LxcwO3eJus+QpjZQ+zgt/NO/kFfhk6seXIUBqaN5y
         A8qA==
X-Forwarded-Encrypted: i=1; AJvYcCU+3Q/B4dvorQXrRpHh7C4lo5xXdDMqsrlP6gQ9whJTymZ9XpdGRxDqxDg/Jm+vLZRDIxup3I0Dnaxt@vger.kernel.org, AJvYcCU1oxFwGepUnjPCoeCpVJKlFS5nHoRui5a9FvAP39ZLPeTQibK4xtaO7falTFjDg6ykaJnu3y4sQoe5@vger.kernel.org, AJvYcCUG+WjwHbqqLWvuLXpbBCL6utKHsU8/kMs9jTnA8sFE7mSfUR3uPFyoI0Gmm4bZO8yGYQXqlCX5YvQhrnJv@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJwei8dNqTeOj/JOfG1cSweTMUZ1t94NUv0Aw0ItVm1VrsVhm
	u1e9syko7u6pQ5WkLZM8FLUqYxY73VAxSipqUpJHp0P4G7aU5zFj
X-Gm-Gg: ASbGnctzu+LjskK8H39LEg3qF8va/WCEXc5GIx6C2kli1XuJB4D76TvJRL1PdmCL5jL
	ihtsUQ5ZQ2ddwh7kIO0MQOEQavWte7MF6L4C4awKzJOU8G2DIvXYGIsfhaHqKGJewl6+UjkXbri
	ze02mPk7F7HA6VRbTkqnohUkDdJ8je4YRGh4vznPxo911ip8oDuRni6z0J9J5hUI2qiXEi/1tbH
	ZqNLaDbBZgADlsW05NrmxxhkvNR/DW86KRATOezAa/1F+Nz/8dNMuAW58dikQI1MvYNG1yvgqxh
	0DuzGL5tBkv/2E3NWN/rsW5LnpHHkIGBT+e1BM6JwBqUxdDoMEDY0OC3kmhKoULU3y1qVMpGPjs
	GLDym8JrP
X-Google-Smtp-Source: AGHT+IEc7trnuoOf+WcMfa6zN9tP2pMADhRPX/raBXFSY9J8IDEUOb3IODRKljuVqg38ONQCP/AaQw==
X-Received: by 2002:a05:651c:3127:b0:30b:a187:7a77 with SMTP id 38308e7fff4ca-319db959b6amr21917121fa.4.1745823276705;
        Sun, 27 Apr 2025 23:54:36 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659c4fsm20017871fa.21.2025.04.27.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 23:54:36 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 0/3] MCP3911 fixes
Date: Mon, 28 Apr 2025 08:54:10 +0200
Message-Id: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABImD2gC/3WMyw6CMBBFf4XM2po+BV35H4YFbQeYRChpTaMh/
 Xcre5fn3pyzQ8JImODW7BAxU6KwVpCnBtw8rBMy8pVBcmm4lootblNXIdhIb0wMR2Wl0Ma0rYf
 qbBGPoyqPvvJM6RXi58hn8Vv/lbJgnBnrub106HQn7tMy0PPswgJ9KeULdaJFUKoAAAA=
X-Change-ID: 20250423-mcp3911-fixes-ef3b2145577d
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=48cNU57hP+b9UkBTib/Cvujad4ba1JubYtk40ZfdEz4=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoDyYXzDADfwYyTazTzjCGvtghTHyJe6Vm4hiTm
 rMrhuRbgbWJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaA8mFwAKCRCIgE5vWV1S
 Msj8D/9JplE+wRUeMCYYV5AqNwZ3WjJF+ZiJg2MUzg4q1EeHvFD0C379j73sX6v3TRJyNiitlmN
 zq0oFffuoAxuh9oOiVvobJwpH+WdySWfV18XyJIBIghJCjq0zyFUDAu4bWr/lUxbSnay5R97LVQ
 O6Ym9Q0ACnxDa+o/IxdT9EhCwOWfQCa12nWEaTixZJAW3p+0ckFh9EpqMlVq++Mva8oYvs4cWzq
 mEhT12llGGVQJebOYHdGEwTlJ89lBLkYBEP1MOrU7w3AeMHscwyU7YR4yuLhwQDjudFSjfcavRd
 vhXxwXpNcTDpsS8sSQB12Jn+j471DGIUcSggW0von7uUquizi68kSjq7hconDeOOn4j/xl0FDfK
 cHtYpy7z3vG5hSg7r3PvrK3wpNnpMxQCNSEF1aq9hzI0A1mKPNMgXHMvVU/0UK/pO5FtmXYqCfc
 8ga9OBDe1k4lCrBn0wMNPwlhYAYVSsl21uX77TJbFeUCnPZ3LsDjFezQUZgSzustiLshjqq/kXW
 KxnbQ3rxZ3X7Njub3yvotrvAnwfNY9B6TflnjWSQX5INEiw0C+a1Uh27nmimfOxXWO4+Eo/6X9+
 XDpXTA6KlA0ODypfFlSHjKapgn+th9MEcW4huQ4arVZReaHuldYytW8c9khhVmdwXKXwo9fXo5J
 9izchAbBIy+7tDg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This series contain two fixes for the MCP3911 driver:
- Add support for reset signal
- Fix wrong mapping for the coversion result registers

The register map for the conversion result registers of the MCP3911
differs from the other variants so make sure we read from the right
register by introducing device-dependent .read_raw() callbacks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Changes in v2:
- Fix review comments from Andy Shevchenko (Thanks Andy!)
- Link to v1: https://lore.kernel.org/r/20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com

---
Marcus Folkesson (3):
      iio: adc: mcp3911: fix device dependent mappings for conversion result registers
      dt-bindings: iio: adc: mcp3911: add reset-gpios
      iio: adc: mcp3911: add reset management

 .../bindings/iio/adc/microchip,mcp3911.yaml        |  5 ++
 drivers/iio/adc/mcp3911.c                          | 58 ++++++++++++++++++++--
 2 files changed, 58 insertions(+), 5 deletions(-)
---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250423-mcp3911-fixes-ef3b2145577d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


