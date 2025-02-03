Return-Path: <linux-iio+bounces-14919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B8A25AF8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5D1888878
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C05205518;
	Mon,  3 Feb 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU/R/rX4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46825A631;
	Mon,  3 Feb 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589601; cv=none; b=VZUF5RXLEle924FmnwDnpZbTG7MlSLnMis1Qq+jsB89o25gUbpdfuMG/6KCTkUyiEVkm40fr5EP9T6EvTSqEjfJ0kIcfWUfEWTNy82RRmmgCtPvyElNgNCzHtjjHz6yrT1ndOzuA7PSXgIt3252afaMcJUOPHRrV54qlbrMmUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589601; c=relaxed/simple;
	bh=yGzpuivdNAxlgO4ZxzCgiv2/6xDGQ7/87DGkiRnqHNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwsvBsU2Qe26aYMquYelN29eMgSdanNNmMauBTbI64oOOj+SwnH3DYQjwnF9ePbByvl/Yu5FpZUEMtJLCsbenL5vSPrsFPx3tk+ajaBdj0qBANnBN2SfNTTdqfPbKk1phpQzhZgaMHVqIznKZN9o5ex4AsYTjcnTcUlDcZeKvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU/R/rX4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2381955f8f.0;
        Mon, 03 Feb 2025 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738589598; x=1739194398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkG3/+OUndAWrWvvhE2SzyN62KNYKgM2eZh+7o/jG6o=;
        b=UU/R/rX47XVRR1HNBfXX3izdbfVpnJUgtzmCQ7PLmLm9H2cvrlk3CvvEEwPvTiwlrR
         aMwtHIr5lSJUR4j3825B4qOSp75P7nI+ErUEPtD0NGJCqfbXWVKxJv4mxedwvXbYLpSH
         V7wDb5hlN9c/vrBw9unYbGzb9jAcjuTn778/WBKSoMUl7Var2je15DDjzo7hFEOO8dgJ
         k+wlMTdj0XKSpR88456rxSPTH8Y9s1crdWHH7xNy7Cs+HFG6cZp5JPeLc2Pwx+NrlHPz
         oiXXoB9D7+dmiC2CVluXDb+7/erTCt8bAKvfCjH0/BbQlqPGUm8x0HjuzSv04l3VPJ7T
         Fo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738589598; x=1739194398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkG3/+OUndAWrWvvhE2SzyN62KNYKgM2eZh+7o/jG6o=;
        b=HhnM9uxg3ZyLQ/fGF7L0mFPr/dkHOKCA/mpIQcmjzrORsFgqCaqeedVO7CXTJ8snwL
         F6r/QFCGJDeGEbFABL0+F06sfhXG6CJyTwc5XzWfOwxGJX1FefFd89H1SIwnMwbgTZBq
         gREa8BW2JRa9Rze8n37a2N2skO5EiRQflI0WPGbKYNpkRJYxc+XqCriYf2sH/shUfmVd
         TwMgb9BJjslwORPezftzwMUwxHBqpci7b8S28z8nb1ZslUQE8jkrZ9eNsUXciUzOZylg
         sA41A6Y7EpIpLbKbyfCcEuR9ZijaU+h9koAy/WuGg1sspCyGxKSBVnsCzIxvgevzaE6h
         TNeg==
X-Forwarded-Encrypted: i=1; AJvYcCUjX6dkQKkdMlzaq3JNbgkx5Sg7Luk2+X/G3U5ex/WFnczq7pd10yPyigHf+xjb76HKilkkbRF43e/2@vger.kernel.org, AJvYcCWBLt2DBagvLbMOdWXk5xEa7INYsksEJP1/wW3bIYAhxaBHPtfoySrfxG8TqwUhOHIZQBqhMVNKwnkaZJVH@vger.kernel.org, AJvYcCWEuSD5VSMBM5Tgsu8D5MO7RETFEza8SuhxDsjBAxzAor32zdLtdvvx4Pxt8NNpmeMQBC7hcNrgojgH@vger.kernel.org, AJvYcCXqMbRqMDPMwhGw05i7iakp6VkZBQ/ZH008PA6XDZAYvh68u2y7qktdXUaGbFN0vbeaI+GdpgaeyFF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxieaPMgaxsOfmbpj/h6vqJF3qRv5vFtvoCjtR/uGiAaqbMtdve
	8tAlX4L04cy0A0/9RVnQfxeWwJz4HL4Gln7rqfKb80w34MRgy7Uw
X-Gm-Gg: ASbGnct2Pkb7UffswxUybEH3vZSQcNVzZIES/Cie4kdjZ7FgAHH9KVZWUW6mZB2VZag
	6TOjQBwtJcjvPjLDAvR40TLd1I9zWTzLG9cWqpUcHYju8WJqZezjF3x2bX31TmBVZJO6pXJN+Ju
	qVpTMuYD8Ink1y1zMORTZmr9ziEtpSo7RU+kH0+DuAHhaMPQRk8lVmwyIJwHwu02JoDZDQfbO0Z
	vyiS6lvc6C79lC0oI11dPv/C8viq9IllJK4rkOk03XiRs5dFy7ymQERwFD7YbjHizNCk0r22tY7
	wU8LcIerhoQ=
X-Google-Smtp-Source: AGHT+IH0YefItBhMFGdcdUKVwSsb1KLZyPacHNakNOpSSl3JJ/1KKH2DaaP/SMD++DSu/bOwI2tIQQ==
X-Received: by 2002:adf:fa8a:0:b0:385:e1eb:a7af with SMTP id ffacd0b85a97d-38c520be00dmr14584184f8f.48.1738589597918;
        Mon, 03 Feb 2025 05:33:17 -0800 (PST)
Received: from spiri.. ([82.77.155.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1d1d03sm12970190f8f.99.2025.02.03.05.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:33:17 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 0/3] Add support for AD7191
Date: Mon,  3 Feb 2025 15:31:25 +0200
Message-ID: <20250203133254.313106-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Thank you all for your feedback! Here is the updated series of patches!

Kind regards,
Alisa-Dariana Roman.

---

v3: https://lore.kernel.org/all/20250129143054.225322-1-alisa.roman@analog.com/

v3 -> v4:
	- addressed all replies for v3
	- refactored the scale and sampling frequencies configurations to use 2
different arrays for gpio case vs pinstrap case

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


