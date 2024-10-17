Return-Path: <linux-iio+bounces-10694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D889A2FDF
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A97284981
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C31D5CF2;
	Thu, 17 Oct 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQCHPgOC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D21D5ABD;
	Thu, 17 Oct 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201173; cv=none; b=ePqcrk4ZOkzyJ7lO/0ZrWcGiks1A0iu0uwk+iML1bpvy5lrSQXcA5vqFqwLlZxJEQaMFZf4ZhvaReY++RGNxoVJuxktV6/p2DVP8issv6ZqTlDz8lrp0RefiE08DGEyQC7NLeUB7JU3H5HctjNLbxW9YlnbFDK1/iZISA1PkpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201173; c=relaxed/simple;
	bh=f3KMSqv/ougYBBA0jBTLNV7hUJAB6jWtw7uRdLiiwi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E6aSlLSoik11cyxRvoPUpylwWY8yfO4iP5OfDcEmkL1EeoxQ4OJ26OiNV4SM64p6vKgHMDNAysVPHgMIS5q2WH59ylABfSSOPdDVyQnuyaoyQa8uiyYRW8xvqvXIzTyrGKGd7i3xoYoaisWv8zCrdd7EYntJciiDBUWbWRM6d0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQCHPgOC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1844467f8f.1;
        Thu, 17 Oct 2024 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201170; x=1729805970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXtSTeKIr7C+v4TkASAN2TDNvn9xALsLgin7qlf7+As=;
        b=DQCHPgOCCLN2ZBdzngvwUmSez3JWZpggr+2CqbKkRGpc3nroejkWapNTmx4xuUe6LQ
         1syq359AIryIbZAdNyfs/PQkUvbxmhY/YX1+IlUSFnz0UvcMy13QNES2/OAo0uf27Ek7
         oowRoDzfmI+j7WWXaK1Bh/ZLc2PH+vFLdrnTdewzxqRXdVoRrJC0W1KJpKRh9QveNK5f
         jMzODkEUi6CyKY0Ziv5OgpZI8YulkUaZsk5kHF0kDxKS8uFE1fuIMo8aVAwkUeRhQGUV
         rC7wrxlrL+WkiTSVJzF0+V9yJ6iSorkVRVkX3xh4IAhA0xI1VM6234LPV2X48zeR+QZJ
         RjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201170; x=1729805970;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXtSTeKIr7C+v4TkASAN2TDNvn9xALsLgin7qlf7+As=;
        b=Gs1nGjmiNBI4tk1Ylzqv6Rgru6jxKYjD8GmhrcggILDQR9SsmY6DyAAoVQeGWi94/D
         Z1/aQpC7nYTVe07LLR/4PEU2iWl+TFflscYIzL6DrPKJzcXL0ScjBRIGSdNgZmr3neTY
         FUNPu6JcNnVFuAkd8hax+BzvNCrNULtBs1TGPDPMkq3Bvh+MVOdffjFyYy6u90ONev0X
         2lJJVwKluUeNv1D+tkF9qH2F3C4McMVaJel0ABx7Bu7rieR3HrU3goK6mIkOXbUJcGiy
         QQbqboPWJElQQhbq3ugoNXlikNRNaEcVDYNTfsAsb2NXjmcIweCzTlh4fYOcfgBjIH6b
         Rwig==
X-Forwarded-Encrypted: i=1; AJvYcCXD2ugNlLg4clTCdupFQVpt+EM4Wqgi+IFMZnDPgF5e8kcbnG0oFIOSez0+N3/zbM7nCkgIoAJKjrm2@vger.kernel.org, AJvYcCXFgSHBHp4eVBq/VlppjMmonAIu8yvAjccHJ1cAnlpi9lGUlMDpMxOPWriAM3B3I4abQNNsrbB9TUkaJ+BP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbuk2MXoGkc1aYY8KQ/uQMxbvA+ZNnYLHh+Cc9jo30HtFRn40g
	QU/VxYSCGIugkog9mcmZtZf8IZO2iYbA4CK7TrHmcVKg7ee4oy2a
X-Google-Smtp-Source: AGHT+IE6iUPY1v5nWaCweLZDZawsr/RQZEFDesDO7/aa0khkmS/UM2Hpmeo/PENgoA+gfyvfLMiydg==
X-Received: by 2002:a5d:658a:0:b0:37d:3780:31d2 with SMTP id ffacd0b85a97d-37d93da411bmr3026966f8f.15.1729201170079;
        Thu, 17 Oct 2024 14:39:30 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bb11-f817-987f-ea1f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bb11:f817:987f:ea1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06a73esm99874f8f.43.2024.10.17.14.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:39:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] iio: light: veml6070: add integration time and minor
 cleanups.
Date: Thu, 17 Oct 2024 23:39:24 +0200
Message-Id: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyEEWcC/x3MQQrDIBBG4auEWXdARZLSq5QuhvibDDS2qISA5
 O6RLN/ie40KsqLQa2iUsWvRX+phHwPNq6QFrKE3OeO8Ndbzju07msmwpoolS+2Aq27g6Rkkeog
 EF6n7f0bU436/P+d5Ab5DU41rAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729201167; l=1791;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=f3KMSqv/ougYBBA0jBTLNV7hUJAB6jWtw7uRdLiiwi4=;
 b=h1RfuLT1jS6HhqTACqxA9vXnkxXcqTROLvj8keAciN0R6bSIuQu5lnqhSLzTA84d5nltRkl2W
 tm+2E89S2AfAMM3zXvdbBxICsV/94d+5aWw/KWBiPZ253GWyJC30jau
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds a missing feature in the veml6070 driver to select the
integration time, which also depends on an external restistor that has
been added to the corresponding bindings. Its name corresponds to the
one provided in the datasheet (Rset) and its units (kilo Ohms), but I am
open to more descriptive names if required.

The datasheet provides a Refresh time vs Rset graph (figure 7), which
does not clearly specify the minimum and maximum values for Rset. The
manufacuter has confirmed that no values under 75 kohms should be used
to keep linearity, and the graph does not go beyond 1200 kohms, which is
also the biggest Rset used in the application note. The default value of
300 kohms has been obtained from the datasheet, where this value is
given as an example (table 4).

When at it, two minor cleanups have been carried out:

- Unsigned int instead of plain unsigned.
- Use of a field for the integration time, which eases the handling of
  the available integration times turning them into a simple [0, 3]
  index.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      iio: light: veml6070: use unsigned int instead of unsigned
      iio: light: veml6070: use field to set integration time
      dt-bindings: iio: light: veml6075: document rset-kohms
      iio: light: veml6070: add support for integration time

 .../bindings/iio/light/vishay,veml6075.yaml        |  16 +++
 drivers/iio/light/veml6070.c                       | 118 +++++++++++++++++++--
 2 files changed, 128 insertions(+), 6 deletions(-)
---
base-commit: 57573ace0c1b142433dfe3d63ebf375269c80fc1
change-id: 20241014-veml6070-integration-time-78daf4eaad2f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


