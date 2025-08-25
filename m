Return-Path: <linux-iio+bounces-23264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB55B34DEA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 23:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160DC242BBD
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1652868A9;
	Mon, 25 Aug 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du/euM9X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A21E9B37;
	Mon, 25 Aug 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157114; cv=none; b=q/OCrH3BQzycFm5ol4oa3qQM4CHt9JLge3F0wpU4/O+XFoWoqtntWX7qVbrqcchDU9TM7MhDCH1bfNIcv67gXLjQc4J8zpZnBx9wlHicu8/0s5BHUVD4scM1FzoJwT156so8MZcvwhnOeT9QoeE+GrCZRnnVBCPX1eYhDBQHEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157114; c=relaxed/simple;
	bh=rQxIqt9FXbMgo+hxm7zsm7EwkedUpyQFNcVlhvMM6JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OwXvj178eNJNdP8BM5/SbAmVAHPaPptFW7QA2BZ99ahZEyOsjzHLY1QSh9LvJbheRj2QQ6EWpRhV7MCavfpyJrBy9nknro0EZfckim11kDrS0SHT19Yi0YI7ooJ7pdVY6tcAS3hx+QQTG5S7DKub+snmOlbLy356DWvDxQ9ezVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du/euM9X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770d7dafacdso1819473b3a.0;
        Mon, 25 Aug 2025 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756157112; x=1756761912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhRjzJlPiyfcS2ozpWwEMLYKLiRTg5NWYtDZLjk6AuY=;
        b=Du/euM9XaZWrJYAu1+DhwFZC+wy4ajvK+j4vZukQFI73wM2NdAcVycypdlM9JOdv+a
         GsrXUr5eNMqdHbCJYKYZ297JHbyv0u7viiVow3hrPaRC0X1pB+2l/6L2TrsbqE2yX+2R
         t3ie3F+oAeC5kEjcKVlpEZiJcX5zzexV5cVBHNSjuH/pewtT7N0XsZVVLX/lAy5KHnRs
         TmNxSFzkfBFhxDdS0Wpuuo0OReS4lXjnpD/fZAYhI4mE8P+I6mkK6EvWlpRHNSSCjVct
         aRn1PLs5kmdMgu6noPejN+t3O2M0z/suL5E20L9b9A8+3Ge3iiTFQsFg6lgHnjxndj9D
         vpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157112; x=1756761912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhRjzJlPiyfcS2ozpWwEMLYKLiRTg5NWYtDZLjk6AuY=;
        b=Mn8Elq/ExP1PvTjUQUx8+iR7axPzC52EzWwrKgVVcJfqJCcUYs+kU+HxBOza6pz4hM
         Gv4/DVLgWnWASXvfaEmGKFGO2vA03dPrmVXrGuJ1liingqdbB9l0/vo2MzuCDcGiybDT
         j/DTdgNN6dJt2I+kGYb6TQgkAM/rvAYcQ6FSolVc9LIbM5pTrWaZWqkwSdqwa4lLS56e
         yv/XCDwysUTylUY5T1rBwPx/8oJ3PFVBGB4SslRjMYlzsJNWNgwDLWxfgBAGpYuSTfuS
         4RulPC4nM0960pfQeGzux8DdWVp1GMaEcz1KZrsn//wiZmk1cokhIu89kvWTZn3wXoja
         MudA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmslu0x1Iy8ZC4EPQ8potBzoUXAeppGaIhS35P393ieMzZsfbEpBKcTjTylT5SUTXPD4/dQis0T1d@vger.kernel.org, AJvYcCV4tLzJ+re3qeA7tWPA82g/NWUO62PGWd7Wv5AIt1+C+OWUNd5PJuX9ZVHdCJCdvlAj9sU37fW8pi1MeRtm@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8GTzIRL3DRUYcB64lcxt4kh7wOUtsF17xaB/I3DjrwNWHD2W
	kEB4QgZRZwhR6YbbwVGAN9aDDz8DGczyfWYRHMl0tQTKlw+BOUrEk8PjMR314VQg6ao=
X-Gm-Gg: ASbGncvTbkS/EkmOaWTf5LggJDroUpzarWN3+KOX6jcglZSX/C+j+E82w7mYlb96KC2
	OB3L6SIJApn/v6RRVvMglVbg4zBix8o37jE1TiyEyQ0Ql10VG8wCmHYGnftSK75MWKKuiT9RMLl
	dA4wngaO43QBIA8KECeNXb7glxfbi1yzwlwLq3srQ+E3F8JMTrfIEAiSJmgXTqHOCYBhxsIHNbT
	Mjsp3eBJJ3JY4LS7CjOolh0UrcgdPl+BtT4Ld9WUxRqNOXOYFSmfvldboqhc2JS1pK8gfhxlEuW
	C16uCWBYhWQhtjSSfbTnOxrhCwjIa3b75vmDAqFniUAnzKs+sNv7wl5wESiZUYFLKihywNr+aK+
	Q/+epojMzWstFjdTIxora6OM43w==
X-Google-Smtp-Source: AGHT+IFiarZ0wz0nrNJ/qvabISz051tH5tU8iSA9KMAy5JPdael09C9wleVkzmDNR3oS5rXFqmdVUw==
X-Received: by 2002:a05:6a00:390c:b0:769:93fb:210a with SMTP id d2e1a72fcca58-7702faac2bcmr16923829b3a.21.1756157112248;
        Mon, 25 Aug 2025 14:25:12 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:38cc:eb35:b786:98be:f27d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbbasm2930206b3a.36.2025.08.25.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:25:11 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alexandru.ardelean@analog.com,
	jlc23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Marcelo.Schmitt@analog.com,
	dumitru.ceclan@analog.com,
	Jonathan.Santos@analog.com,
	dragos.bogdan@analog.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH v1 0/2] Add MAX22530-MAX22532 ADC Support
Date: Tue, 26 Aug 2025 02:54:50 +0530
Message-Id: <cover.1756115378.git.jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello iio/maintainers,

This patch series adds initial support for the Analog Devices Maxim family
of MAX22530-MAX22532 ADCs. These are galvanically isolated, 4-channel,
multiplexed, 12-bit, analog-to-digital converters (ADC) in the MAXSafe™
family product line. An integrated, isolated, DC-DC converter powers all
fieldside circuitry, and this allows field-side diagnostics even when no
input signal is present.

The first patch adds the device tree documentation for the ADC. The DT
binding has been verified with DT_BINDING_CHECK. The second patch adds the
read functionality for raw and average ADC values from registers.

The code was tested with Raspberry Pi5 and MAX22531_EVKIT_A. With the
current driver version, it is possible to do single-shot read of ADC
sample data. On a preliminary version of the max22531 driver with
debugfs_reg_access callbacks, it was also possible to read/write from/to
different device registers and obtain the expected results.

Details of the test setup can be found at
https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/max22531

This code was developed as part of the GSoC project for Linux
Foundation. Many thanks to my mentors Marcelo Schmitt, Ceclan Dumitru,
Jonathan Santos & Dragos Bogdan for their guidance and reviews
throughout the course of this programme.

Abhinav Jain (2):
  dt-bindings: iio: adc: Add device tree binding for MAX22531 ADC
  iio: adc: Add initial support for MAX22531 ADC

 .../bindings/iio/adc/adi,max22531.yaml        |  75 +++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max22531.c                    | 191 ++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max22531.yaml
 create mode 100644 drivers/iio/adc/max22531.c


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.34.1


