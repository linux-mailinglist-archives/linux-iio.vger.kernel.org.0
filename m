Return-Path: <linux-iio+bounces-25810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A0C2983F
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C521342109
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 22:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E81F541E;
	Sun,  2 Nov 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCT6I/Jd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5D4502F
	for <linux-iio@vger.kernel.org>; Sun,  2 Nov 2025 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121814; cv=none; b=O0Wc9SFIJcd+0eNwUdpM+cgETOiYCEX7sXhzAikjCVCokXIOYO25vleGtyZ0CP6X7IRUw0CxR1YBiVEfhIuDvJ8HXw+D7I03gkfQCJFht/eG3IZZP4RNs+8OjGgqLtoz2WZorEp4iTXtUOaNymAtimChxZkzasNkG4wre+535/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121814; c=relaxed/simple;
	bh=wsAWTN0eLlBiEGL/wUQ4n2on9qNGbOthalUagaZS+vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDMGC+Zn6S9T5jpccTI4kJWhArW9xsO7WVC416WWBDrJXifKz0kMWaubhGQ6wNOc75FRkcTMWW0Q1M9vJ5CuKqybW3XWV5bdgNTnEkt1CfVIxga5J/Aiiq++Tg7270eiMsfu/zrS1jE4YB5fDHViouVfVtZWlT0IR4bUMMyVAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCT6I/Jd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953e415b27so18097995ad.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Nov 2025 14:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762121812; x=1762726612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzTHM0N5jn83Spik5G9PnfqO4YiXJ2V5D0HuVfUYWgA=;
        b=aCT6I/JdqXsFRbnj7T6LoBtwG/d1v740suzF3xklap2abkZ/XyIxj/qho1HwA8E7Il
         d17elz4VXC+LiQxv73koSfIRt6yn8fXMU2cc9e/Ph5SIxF2oeXon6JpUGkoiU4AUOIU8
         J1gGGnu7Tj3mszai7UUfcASTa6zBQySyz2t+YC7YHIgIxWffijKscRWPBDZXbWV7WVuF
         FuWedk5bSyucfuljK6U0PlnFsdkLH8Fy6rjKQ7yVfd7bsHwY99FgKKjjuDTL+ARetDx/
         zQm8I+1MQ+iYV4mQSc5GARaBuGB3JG3hE6fL/zMU3NoyIPdfVF1rm3JwaHQLxSlnnb7r
         ZOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121812; x=1762726612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzTHM0N5jn83Spik5G9PnfqO4YiXJ2V5D0HuVfUYWgA=;
        b=TV/fD63ORGW242c+XDV0sHvmC24vbZB9cFUS1esaRI+267cDjVms3YQaSUUchlljeE
         zGRfIGNm1d70xXvGA2q9RWNPu5gkH9dSFhZdIT5lml7vEVSXNmeHkqRiua0JhZozLtta
         4ft78cFHKuxGY2/W4DjZPxayAP2J7qYLJXXG1m9lYoxdv+0aMn+j/YAlyoVpBNPX4kJI
         4ryMBAIrKhi8ZUcVPAJwMUVUgnz/wfukOTA6JEEZegushcqNgsi9mQ2k9iXUMUU0+GxQ
         yS8XH6utckg3SifGSPQA+mEf6pzY478AXo0cn2kJTogh5z0NVvNVZQfRFr/h/nVNphmh
         YrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj1cTU1sMfCgXcWIQlHIqfzedv+8I5nBUnpiMf8jQxOR5T48Vp8JjvKLKe8YkfHrmTrvzq4a8fCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWV/tCLpFUgfMKjh+Y5vgbd7kzioTma2IEoB/v1B/1veGX6tS
	79guZkRkwzrYYJZYw6NwpadxqVW+N3u9E3BTMeYky2l+Iat3k2Ad/9TS
X-Gm-Gg: ASbGnctA3xiwTZoXiPz+f9+ULFEWwLz6RaCcGuiEGEbRCjcyjW1adK1fIVrprTLYWN2
	C3myZAJzlBs8McoKoI4bO3Vi4jjXZ/QMwuaobmCOLGWuWAmvkhZ/kqzPj3WgzirpNg8Cw/7cH7Z
	7TdWk11NvxCaOZi3XySDewLie63//B4otMcY4+0atctlpRaE4VYWjzxT0ZOC0EDUilD/iKucUOo
	XbpCbOqXwX+cPr+bCOopkfsHmaLjkdeiOsph2E0iRQF2mk+WRcThQkSmxowTDYGSKBE9YiqE7nY
	W/hseKgD+Jr9w3Amu7+S82O517dmBNv3HOi25hvGXlOGei6APXCXZkzZvMw+yjCAgLjYFF3cDdU
	cEG6k4GTRDsTQTf0eyCpQRsLfehLTOUSK/LM+XBVbcLU3cIg7D+rcb4Q95KsGYZlHyZgVQ7KxmP
	sT/A+BYhK65uWi5Z63Z4NMQlE=
X-Google-Smtp-Source: AGHT+IHVVJYWd8UPKfc0DgSAdtRg6W9eUK9Ue+pS4SyVc2z0ghJlZAxip8Z3wthzYtVrp4JqIN7pxA==
X-Received: by 2002:a17:903:1ce:b0:294:f30f:ea4b with SMTP id d9443c01a7336-2951a3620a9mr122622075ad.8.1762121812140;
        Sun, 02 Nov 2025 14:16:52 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:860f:2214:33ff:7c70:4d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295357a1851sm83362835ad.27.2025.11.02.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 14:16:51 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com,
	wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] iio: proximity: update Lidar-lite v2 and create v3
Date: Sun,  2 Nov 2025 19:10:25 -0300
Message-ID: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the Lidar v2 binding from trivial to a dedicated place.
It also adds the v3, which was not described yet, in the same place since
it's the same hardware and it is already supported by the driver.
---
Hi, all,
Very few changes in this v3. At the v2 link, there was a discussion about
the PWM output pin and the current support of that. It was suggested to
not add that pin here, at least for now.
Tks and regards.

Changelog:
v3: split things in a patchset
    replace power-gpios to powerdown-gpios
    user proper lidar node name
v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/#t
---
Rodrigo Gobbi (2):
  dt-bindings: iio: proximity: Remove Lidar-lite-v2 from trivial
  dt-bindings: iio: proximity: Add Lidar-lite-v2 and v3

 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 54 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

-- 
2.48.1


