Return-Path: <linux-iio+bounces-23104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34872B2FB2C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E842A623A3F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983E35A291;
	Thu, 21 Aug 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeKQLs90"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0502FB63D;
	Thu, 21 Aug 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783498; cv=none; b=DU6NBm5gZNjMgs54v/mv4G51y5zU5H5nlY6ErcQOXHEVWhsMPtN6bea9YNKcQ6lSwAOdnGfYgGQXDIRc6qFpgzOgPb6ViEK3nvPREO8tJAmWMHXZLQq+OWY/hxCWZsPHx6o/iiFBm8aiTYQ1+bJuFIVYTlxiMJvtUN5Pm7KKnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783498; c=relaxed/simple;
	bh=jpyyfJZ3wZjnpV5SblE0NutxVO+W/yDeF8Nd17GPfHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uy9X7sUshc9k1Z9DMTVzu2Hniaxq7YO+UQSpWVQhFPkNHpsjO7KARRHzzpTBEly5U2foZYydW+klDcDSDA/yX5pEj7+FeUTkWgDY9I9BdJ5lBg7LZC6c8l6ujnbuu0+vhPAeLlprQdRJ3XDO1LWpguiu0+7pgQSbknQYhXfQt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeKQLs90; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b471738daabso864269a12.1;
        Thu, 21 Aug 2025 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755783495; x=1756388295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esEDUmE0VIr6GRhE45jzfN1SkKfoVSy9xWBhokrQK1s=;
        b=MeKQLs90Asmq7Tj9dYCwtaeD/HzclS8QYGZfcCIe0KjgVWnYp7YDwwICYJseud4iw7
         dpHX8oDqLh015wlpH3nfmgs+MDHccSjkibEGPChRwvVcoJ78ENBOyX2MgDiG7mZEgNWJ
         VkO6fcv6+udjHwzmdwj87RmWP3dTvgMnCB66H9jeqPm71piNHzXw5phNe121eVp+QOAT
         hCjVcy0bUa6rogclyqyiPe3+KNJVWCJ61uB5kpjhzw2XYj6CgsR8pkAOt0R9cQkNkDCL
         mAxzdGc4mh0gvCwmkB+rqeJYFS0KM2luhQW59/kTPpJdigJExoClFXXKEMF9gsYeQHSm
         EtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783495; x=1756388295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esEDUmE0VIr6GRhE45jzfN1SkKfoVSy9xWBhokrQK1s=;
        b=EJbQhnMi/yfaU8AyMfpAirLVu7WtGFGFEqcW8wbIwkxZ2CMocL5Zm64OjR2To59tCQ
         LqYAR8hKt6h3gV6Nc1VyO/Yq68ldLBqRyBhO1ruc5jbnEihcJ7Sng12svLg/k3o9LqaL
         3hnAXvjQ+VGoWnd1e5sB3NsSAgW1kkfzNxmP6vZSCLBBceVP/QPu7FQJFaCIvj3qI1IV
         1e5y9/8VhbwK7D6FGWFqhfdVie7wAcfFZBP1KP9bAFMsZNGYQ2HrRmwJlPR9F7xHnyCD
         qckdeWoCrd3+ETFvYDUv5Vkd9lkGL8Su9Jh9qA/lZ/js+127VMeDiSF6lGmkjhvFLGNU
         Y9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpUzyhk/ivf7bQKYKxX6cfqGhfQ7kzSQ/P47WCnQv56ER99kfOY7+7S0LsD+FsU7cC9MUijWQeNSBQ0P+u@vger.kernel.org, AJvYcCXuBqq14WaMeUBTHarLkrc2S01TYIbOsy5vW1ddV/WOiH6VjwVTSnb//NkBX0VUuI0qeRNSLjfJmDkO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fwbjSZulNNpC72enYRdKwoyYcPLjFdfNjTcAC6tjH73VhOeo
	k063p7NaK+vxWLG+mK3fSx0ycTiTpPfmycfY5CE9DM6i2TGqpPfRikddJOQ2foVMeRs=
X-Gm-Gg: ASbGncuX8N37OA3DjI6ChlWqb4O9vA1UDMVlOYh1XAxRVYuuop2fHw2B0NsvIMta4YG
	6bKftn1BRFWIK44tiD1CEYy4l9b9qjmyxTtIOT48wa6wOykAuiuBZeLLJg5ByS+6BZxh5hj+sXh
	43SkG0T9iblkL3nHmK2MjJVdLi6AcdMWf4/OZfsLxGN6EBiDR/v66Gkxx6GYvbvdb2uh2emxzcx
	o3DZ/6eX5MmpDepwTcLIAKiZ5GiGk4iRCSOClpS3xUpQpORD9dwn5DJ3GkSjjSTH9DwOEZfuqkB
	S6MaOIUL4OjNLp1fgiqIB0EdJyVLucxByxblM0Z9708JQN2YiK1bsJyhEFyatjH5XEfkZZQ2KdQ
	Zv79TJi5ik/hi/zFrXb8H5An67sCxyCc8hmffHwuqErnEAw==
X-Google-Smtp-Source: AGHT+IHgverFFgcsM9ygJ2BBNvU8MobgERrhsHsqO7oSPjujuH8HZo21nsDpSJc3wdWFWXsZ07MtSw==
X-Received: by 2002:a17:903:18cf:b0:23f:fdeb:4171 with SMTP id d9443c01a7336-245fedb032emr24346475ad.39.1755783495351;
        Thu, 21 Aug 2025 06:38:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:9c08:cdb4:8bd9:b0e0:e77c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed336002sm56660795ad.5.2025.08.21.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:38:14 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v1 0/2] Add MAX14001/MAX14002 support
Date: Thu, 21 Aug 2025 10:36:06 -0300
Message-Id: <cover.1755778211.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series adds basic support for the Analog Devices 
MAX14001/MAX14002, configurable, isolated 10-bit ADCs for multi-range 
binary inputs. Besides the implemented ADC readings, these devices have 
more features, like a binary comparator; a filtered reading that can 
provide the average of the last 2, 4, or 8 ADC readings; and an inrush 
comparator that triggers the inrush current. There is also a fault feature 
that can diagnose seven possible fault conditions. 

To keep the commits simple and organized, these initial driver support 
patches aim to upstream only the features related to reading two registers, 
one that contains the latest ADC reading, and another one that contains 
the latest filtered ADC readings. Though, _raw and _mean_raw are providing 
the same results in this initial version since the data averaging config 
interface is not implemented yet. For this, IIO_CHAN_INFO_AVERAGE_RAW was 
used to return the filtered average of ADC readings. An additional patch 
documenting the in_voltageY_mean_raw interface can be added on v2 if that 
would be desirable. The idea is to use in_voltageY_mean_raw to return the 
filtered average value, and also to set how many ADC readings (0, 2, 4, 
or 8) are included in the mean calculation. I would also like to know if 
you have any feedback on using IIO_CHAN_INFO_AVERAGE_RAW in this way.

The changes were tested using the Raspberry Pi modified kernel version 
rpi-6.6 on Raspberry Pi 5 hardware. For testing, the MAX14001PMB evaluation 
board was used, which contains two MAX14001 devices. According to the 
board’s circuit configuration, one device measures current and the other 
measures voltage. Due to the evaluation board’s circuitry, the devices 
also receive an offset that allows them to measure negative values. None 
of these evaluation board-specific characteristics were included in the 
driver code (neither the offset nor the current channel capability). 
However, they were considered in the calculation of the values read by the 
devices. Should the code that applies these board configuration parameters 
be added as an additional driver file inside the IIO subsystem, or should 
it remain only in a user application file?

The code was developed during the GSoC program as part of the Analog 
Devices Mentorship. Many thanks to my mentors Marcelo Schmitt,  Ceclan 
Dumitru, Jonathan Santos and Dragos Bogdan for their guidance, reviews, 
and explanations about the IIO subsystem code.

I intend to keep sending patches to cover all the features of the device.

Thank you for your time,
Best regards,
Marilene Andrade Garcia.


Marilene Andrade Garcia (2):
  dt-bindings: iio: adc: Add MAX14001
  iio: adc: Add basic support for MAX14001

 .../bindings/iio/adc/adi,max14001.yaml        |  78 +++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 213 ++++++++++++++++++
 5 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: 7c680c4dbbb5365ad78ce661886ce1668ff40f9c
-- 
2.34.1


