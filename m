Return-Path: <linux-iio+bounces-14706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B93A21F26
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0947163FC9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E11ACED2;
	Wed, 29 Jan 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5psjeig"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77C8F4A;
	Wed, 29 Jan 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161069; cv=none; b=NehvOLYz2xMeV2qlx7SAy0izrW0MZrpJPNhkCxU0NtkgbsErhRKvkh4fMbNQ2AGBvk9XDZcX3JGyV6cOePAW7HC+c+qibBW7fi3IROhT9dTtiWfcOgsvz3pjMY51ssHIlshU6eor+TSwXo/SmSQopX5QencFKGyoHY/UFUVsR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161069; c=relaxed/simple;
	bh=FcXgyIivx49AZaW56v7gXTj5YhT8hxXrGxu8jaRa20c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueoGs7DAA1yQ25HOWwpEMf5zAavvG+I+zvqx5/ZKSjCNLTQYR9ErBxKcj+qxYj2it6vcGoUaBwSJbJxNSRXYjdCiddBL5RgKKVYHxPg760iDDluj1Eq1QuwSOp0NbKHeOY6mSbAbVF/knpJhWVO+6O/oFxd6on/8MEznee+fWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5psjeig; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so3682379f8f.2;
        Wed, 29 Jan 2025 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161066; x=1738765866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytQod/TtXir+lgbcpVQDva+UZpavOsy0mPhHQcNBVUU=;
        b=K5psjeigqNXkhjpMBa5mrbyXV6ToyPCEgIwH1EJUhrMZddGjsvFTIA5XhlwUMvEwvi
         TNjnGCroWI2VYiQ+JVqfObQk17mStsc3Ujf4nS2W4zNfB7ITxY7HS/90NeE45o7t7Itf
         Rz9kyV8EU6EeOMNT12O7SwIE3GRBHzDfbKzJg2EpDlMTkxYlRbQAjU62QLvrRNwFbIKd
         AX1tGSPf0l/Hv9YuJRFWfmdhXbIg/jOOqBj/Od7ICKXCLpoDawESqBewTwA9o8M3pg/W
         B6fmhHVlPY6xrXeRAOk8H6JUsEieD2c9z9IHfYgiJrHWICIOK3LjR6L6CPlrmiroVBz3
         c1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161066; x=1738765866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytQod/TtXir+lgbcpVQDva+UZpavOsy0mPhHQcNBVUU=;
        b=PmQ2wyaPDqv/DrslNFYK4+qQGDxV7vmQwDUCy73ZAEpijDP5lxVXhhNdnFVaxtvmJ8
         A+DgGI2ko2tMANifvGapE1cX7fmnnq6/i5Xq8NtBmAToIQ4sjKMZalafnjFb4XrGWE5d
         JDilai7DTXhU+kqHukD43w5wbnw2E4yFMSbkRmrelGKf5X5BUQ3rTrd2GqBfwv15eg3+
         jMVEJKk0IywSgz5yCr2vbo14aZ1Kjo3aFnBCFy0K3gfS4DZfeyTNjQGyLxFS8bD8Qyi2
         Zj4iLqLzzz2P1TaiXLG6eZyaFV+MpjJ3jFL3qvWMNBlD59Dv+7++tP4vKxk1iQNNGYx/
         I28w==
X-Forwarded-Encrypted: i=1; AJvYcCUK8sk5SKf2nHhtAwOFRuMv2xZwk8WhRbzAW3MpDAbXaVOA/9ka+6a4Tx6gBriP/j1Q8oNrXDKkYko3@vger.kernel.org, AJvYcCUYOYXQ97TFA+aH1oRuefDgkdEYYmeQYmniDz9f7JCmm/fug6w1XLG28C5syI7sbAiUt7+Msni1dlYy@vger.kernel.org, AJvYcCWAGq/RgQqj2Iq+pR5Jf31MObvqJgjRMP7k6wSeSReyZ+CWlsZSqMG0YoGIh3YulojTY0zNN0T1qETI@vger.kernel.org, AJvYcCX/WHv+hyUvkue3QVTj5wjdKhgw+dBx1H7bBGLRzuqRm+tCS6OYGxtTMBug66DJqwvzBaEYh7WsjyEYFHEa@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKai9aaxlXHFbM+lc4hQGOyi9o3RocFMLSWRayMlecbnuH2vA
	PO9DPRFVFmdhvi4ialLqT/nYa9rO9F0OG61fufps6YUAkU+/pkVwscjJxg==
X-Gm-Gg: ASbGncvQvfJT//VA/PXUplXW7W6U0BO15Dx4soUGHXP8A/cBui1zr8O2z5D+in9bNtu
	ZHV1Oj2/PaksOzjvLlAN5iRyJOT/bH5N+UbdNa5zFBdCuGKx4F1/3r85ZLmTKaN9YmiCurYMLm/
	HQqHwzB+SdgKnokBgq5/RtG+ASTVpwnb6ENRxRNCGYjvRB0vqxb+QwuWp1XvX9rAOHSVAXTJ1e8
	fI0GQROUqbUfd5SatqnvrM6PWJzajnZlBkSXcPpm822cMfkJZB4BZf+zjWbDtkLxUAR0auwQSln
	r/FGIDnZrPw=
X-Google-Smtp-Source: AGHT+IEkYN1blNmo/ag8BHYSdfY2J+/Gmwq/Duyn9qyH0VzAY6O2WJ/WYyKGG4ohQR21Nj1Cjc1cyg==
X-Received: by 2002:a05:6000:1a88:b0:38b:f3f4:57af with SMTP id ffacd0b85a97d-38c5208e9cbmr3557747f8f.35.1738161066018;
        Wed, 29 Jan 2025 06:31:06 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188c28sm17596201f8f.54.2025.01.29.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:31:05 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 0/3] Add support for AD7191
Date: Wed, 29 Jan 2025 16:29:01 +0200
Message-ID: <20250129143054.225322-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Thank you all for your feedback! Here is the updated series of patches!

I addressed all the replies' points, except for the one about the size of the
avail array being 1 when the pga/odr pins are pin-strapped. David raised a very
good point, but, for now, I left the size fixed to 4, since the functions for
setting the values return error anyway when they are pin-strapped.

I thought of 3 approaches:
	- dynamic allocation for the avail arrays
	- different avail array for the 2 different cases (pin-strap or gpios)
	- different channels array for the 2 different cases (probably too much)

If the current setup if not good enough, which approach would be the best?

Kind regards,
Alisa-Dariana Roman.

---

v2: https://lore.kernel.org/all/20250122132821.126600-1-alisa.roman@analog.com/

v2 -> v3:
	- correct binding title
	- remove clksel_state and clksel_gpio, assume the clksel pin is always
pinstrapped
	- rephrase clocks description accordingly
	- simplify binding constraints
	- specify in binding description that PDOWN must be connected to SPI's
controller's CS
	- add minItems for gpios in bindings
	- make scope explicit for mutex guard
	- remove spi irq check
	- add id_table to spi_driver struct
	- changed comments as suggested
	- use spi_message_init_with_transfers()
	- default returns an error in ad7191_set_mode()
	- replace hard-coded 2 with st->pga_gpios->ndescs
	- use gpiod_set_array_value_cansleep()
	- change .storagebits to 32
	- check return value for ad_sd_init()
	- change to adi,odr-value and adi,pga-value, which now accepts the value as
suggested
	- modify variables names and refactor the setup of odr and pga gpios,
indexes and available arrays into ad7191_config_setup(), since they are all
related
	- add ad7191.rst

v1: https://lore.kernel.org/all/20241221155926.81954-1-alisa.roman@analog.com/

v1 -> v2:
	- removed patch adding function in ad_sigma_delta.h/.c
	- added a function set_cs() for asserting/deasserting the cs
	- handle pinstrapping cases
	- refactored all clock handling
	- updated bindings: corrected and added new things
	- -> address of the channels is used in set_channel()
	- addressed all the other changes


