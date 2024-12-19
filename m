Return-Path: <linux-iio+bounces-13692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E39F88A9
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 00:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5541896E78
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE01E3DF7;
	Thu, 19 Dec 2024 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9/vtLMO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B01C3F13;
	Thu, 19 Dec 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652074; cv=none; b=Dtwgp4tFgBr2M+b0BPaJ17Mgu9t3JTmTAb0WkHR0x+MvWOuEwOscxe1/sxm35HOvRurTDQ0uuju57Laj04K/fQn/keySWWvgDwMX8h44bjHmzz91rB5486aB1OPPPRdKjz52QIqFXXY4ua4QJ6YJCbjFIe/G030lYXImYUZ6M1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652074; c=relaxed/simple;
	bh=sdUmDKcfPfqWcXZakC2N0UlxbPCbZz0TqBbc/TkC120=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgeYr4F3i3JbDqGQkJ8krXYQ5lnpGvSUpixdNxGwf1QNmDJoNNNZCTqCuVKXC/KTAW+SscdwrUa+6IE6upKlYzograuGHls35PcNzO9NSBqihBoUcgfQtqNpjEu0VF3+pY5g9x33J82nRfHs/+nu9og8OeXT8QeyMXGFDP0INoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9/vtLMO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6a92f863cso271071666b.1;
        Thu, 19 Dec 2024 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734652071; x=1735256871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ni6oAWNRIy0+3xjABdX9ccWVTDweGHn1gFcSPXt/pQ=;
        b=P9/vtLMO38laMMEbaoy1pyDeOKVArALsRJFbEKlc2fxlDAMSbUG68RBquUD2CjFo8p
         VQueG2vdLO7Pqg5yaDTDEqAMzyAGXNN9dITuaoaSNBPnoF6XtT/dWSymDD9iZVuoNMKk
         6jOSalyLxL2ACaC/ldm3nbmjCsWYEbIVTqbH5R5Z64JyXY/ftnw7FB0FZWUVX25sRUoQ
         Tu6yR/vme+G/v9ZJWBLwkto6AhLQcohq2nzICACd75/Bb46k9eNnvpLTtCTyFZiUtild
         girIelWGteDWePKouSxfiJGXTVRDbT4nrEQI71dW2ekdE08nAh9cIvgUNd7KMU8n68Df
         rnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734652071; x=1735256871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ni6oAWNRIy0+3xjABdX9ccWVTDweGHn1gFcSPXt/pQ=;
        b=EfOuH7jlxDWhbRJv14EV2IrrDPp/QL/SUBSpnK4nHYeC6uPI2xNaYfzPDy0V1bXYwd
         JsBiBnP16V94B/ix2MnvSVrZUu6o1M8F+QMxGaGzMb8BOM9m8WKQZhs2ktFBhk/pg4cC
         5/HnZ9e8SUlTAONIjQzJjazQ0nw8husMdm6xuToF28i1vslQ4DzcMU85kKDFpw+bX/x9
         OcwrwFCfV1QSkeB5GQj4wy9gTGIMXHoOV4uLUwrbHTKjwzpWXvkUH8UF+4c4eLKqcNQk
         il6/ScXRIYIIdHyDsRy4z/b32qcX4oOlGPedPcJzrLpEeEZHHX38zB8zQFv/XzRjZWKs
         /hDg==
X-Forwarded-Encrypted: i=1; AJvYcCUfvbGVkbt5dxtYuoG1B2fslnZLJ+5hJKgDV/bNhuNyOBMETUT20E6rk2FiQ44Tq2PkjNULsmmXSIww@vger.kernel.org, AJvYcCVS4d2hIMw42VsvDPdju5DgDDqLhBP5p27PlVxi2jFbJXNH/CfmzKsO8pn71o56F5o/4q1EL87B9+CL@vger.kernel.org, AJvYcCXbdQkDHZrCN1rBWJT9hGH75FsE+mUxJnOAGDjoEQT0oiqcT5fkY+qATa+i9CCB7vI7PQkaJ3QvMgb3WwO9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09oJhOW39DI8LL85ZXAIBctUCYRmakTh3Ecyl+epKa0m6WRIv
	5EuthEjLEAC26VsFLNysOi2ZJ8Q2kn62thQ1Zp/hDF+nZRqEaZ5q
X-Gm-Gg: ASbGncvJwA/sO/ew5cqFQyEP/e7zrWFWF+1zlZEy+5x1MHyQmAyEdJJHHHEpUPc6t6p
	RPaz/ry9Zk6tgD2ZIbE4Q8t19BSsA6xxszrqNnvPfU3EV5wIMDrgYW4tdEpXrnn+YZux9xn29aG
	dCjUF2RLCezTSEJtLoAnsA6ya77OVlhyGBnp3rZERH2WPtuAl57lvzqf+R4Bgmj4Ul68dwgQLfM
	WtHprN8VxMyLWs4zG0ViNVdt9nlCGlAurttz9CaVHk0dM+nqSAnLsu8GokFi/0plwGE
X-Google-Smtp-Source: AGHT+IHXDxDv4ngG0FTxDqC+xYCCsBo3w/NFsnR2BSHQLzfJW4lobeMec1l/Z6VdBb6A74eyL3EvOQ==
X-Received: by 2002:a17:907:a03:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-aac2ad819ffmr52229166b.20.1734652070638;
        Thu, 19 Dec 2024 15:47:50 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:6db1:ccfa:1b4:55ac])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f076d1dsm113244866b.204.2024.12.19.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 15:47:49 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lanzano.alex@gmail.com,
	jagathjog1996@gmail.com,
	vassilisamir@gmail.com,
	trabarni@gmail.com,
	danila@jiaxyga.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] dt-bindings: iio: imu: add missing property type
Date: Fri, 20 Dec 2024 00:47:42 +0100
Message-ID: <20241219234745.58723-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that some drivers miss the "type: boolean" under the
drive-open-drain property, so add it.

Vasileios Amoiridis (3):
  dt-bindings: iio: imu: bmi160: add boolean type for drive-open-drain
  dt-bindings: iio: imu: bmi270: add boolean type for drive-open-drain
  dt-bindings: iio: imu: bmi323: add boolean type for drive-open-drain

 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml | 1 +
 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 1 +
 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml | 1 +
 3 files changed, 3 insertions(+)


base-commit: fe2a04fbcbfe44694fcb36ff6212fce54b8f56cc
-- 
2.43.0


