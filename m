Return-Path: <linux-iio+bounces-18584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B789FA99967
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615013ACC71
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD7E269CEB;
	Wed, 23 Apr 2025 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO6EAobH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3D191F6D
	for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439823; cv=none; b=WcePEdWGY9iWFKHztS8xYskFmenbS83PiUfg247KcUQPCc1WfAP6HgEWfUK1zROTK9SEA8ff9EwW5AtQ2KMdgaswkczaRoU+7IMcF1TJZ5S1xn/7xUXOUoowWlVaMwn8n5XYh20wlxZ6LrCUc+YU7KNihZUiFrW5LcSwl24XSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439823; c=relaxed/simple;
	bh=Dzj8405t0yaieU8jvpNkE2I/pWmh3cVvlLy8YA72ovI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FHGN0RvZMUYSliBm1YTjOWPiSfpgkUUCIrqcNl/GM0gUkQFKDC5FY47iQVNMbKJD3l3+ymDX8r+tzs8VChoBQQcT+qrQiZfvOb1HudBNcRmF7fh21n4RxfL3waySIdMMlwf5x5tIgIsqsPXoPYdWsBIgvtQbDk3vJrJ52gp06WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO6EAobH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d65eb26b2so190913e87.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745439820; x=1746044620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Awu6RQTROdXNX2XQJGE/EdFOmpjpxGdHJVGDRI5IzsA=;
        b=DO6EAobHQSm+A2asP8m4xJG5WYWsvvY3QYJHMpDwCGDqunbisLui0NeQBqQfHKFkjQ
         hffBLAlwL7z1LloDiHOExiYexIRHbRxOcfbtJ1iQz/kqMp2YgK7rR/HTaMvNWRxpQmI5
         RkZI64bcWklZ6sjTk2h3HCALqlLhwNkrtWYoS+vK9w6cE6CGz67XUsIzxQEd02rrOj1c
         se30fj2u8WN4NN6/Wrl+m9pmCfXZQl3X5z4EbU/VEfs07AZK82KBMnlIqFFHCQHgVzdJ
         Apd1c0UApVDp+uG1GgqG6/s8XRYU0W22B/nzbIiqQWbYD0QNNbe0+1MWFx4Uy1m/Ko2W
         YgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439820; x=1746044620;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Awu6RQTROdXNX2XQJGE/EdFOmpjpxGdHJVGDRI5IzsA=;
        b=L0mQNOw6gXICzjU+Q2RyFaQqzMZDs3kNS3EYXTckONeT8Xo9tVkdAbJmeUsCN8YE5J
         R13Ka2pkOZ51UVzwF1GQeNcui6rsck9j+yi0/EM5vYltcgHiFRnHlR7cG8qN/I/dsGV6
         YZe3Z6PcK5tUNZxHc6UNHkSe9Mlv1SfyKVJwYxgWC53lGzYEaLncoXGdE1dds4LIKioL
         tydKZpTtKSuyi+kP+WIeuRhTqGqY+qzpmgWFbBb/UyfTFFROWyrKWJAqe1CpTIl9HkeN
         ZPydKpUOBaQMLyidT3DOGZlqVOxnwJccrABr0vbrUEcdoRXJGOY0QfH8fJl7nA+A3Map
         Q/3g==
X-Forwarded-Encrypted: i=1; AJvYcCWKLx2FBhIVi+91MKVAHj+cRBB6eA8E0wA2Rb/zChnuZ7EZ6BltXq7GB61bhnLa8ljZxXSVlqRk/RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfpIqevbWvEBrj8Hoe7ocB4JxhzOd0x0QxyqPqj74jaU11yJX
	o0lnaqCnUjB8d2wcEkwqKbtnLbja44UlR13KrymJZ+7KPjeFZst2RPNvoTe5EAeBusuq3Ylp509
	pjdLM3o/LY/0yX5dtzP4lQTRBh/Y=
X-Gm-Gg: ASbGncvJJA+EIUOCUFJs7/OaKeJDu+MVU3ps5wipugst0KUF0rXLvkq7ACdvmaNS/rx
	V1iDWBW9wgX98ohmcDP6ombkZNrjCINoZ2opNUvX4IEnSKicc8xU48UEjHFLDx1T9lkuOYcssKH
	o+iW1WKIxDFc9GEt0yM19U2HkYX4jWI5/rXi2PWhhjx9HZfnsdNmYZ8g==
X-Google-Smtp-Source: AGHT+IEOlGuri6Bun/neKTDIAX7EnJBwC11RLi0ZXZ1LHw7AYs3vNf3bXdVrk6m1RT2+2CX+1IEWaTYf7/YIPNHxRl4=
X-Received: by 2002:a05:6512:3b82:b0:549:8c86:9bf6 with SMTP id
 2adb3069b0e04-54e7c420de2mr68647e87.39.1745439819743; Wed, 23 Apr 2025
 13:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Apr 2025 17:23:28 -0300
X-Gm-Features: ATxdqUHJ-L2uxpLHRSlvKB1sjr52TckvGZh2SDwE8KrqSy0nylsYmwwxqRJ6fIY
Message-ID: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
Subject: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

After upgrading the kernel from 6.1 to 6.12 (also tested with
linux-next), I started seeing the following warnings on a board
populated with a Maxim MAX11601 ADC:

[    1.554029] max1363 1-0064: available_scan_mask 8 subset of 0. Never used
[    1.563627] max1363 1-0064: available_scan_mask 9 subset of 0. Never used
[    1.570439] max1363 1-0064: available_scan_mask 10 subset of 0. Never used
[    1.577328] max1363 1-0064: available_scan_mask 11 subset of 0. Never used
[    1.584226] max1363 1-0064: available_scan_mask 12 subset of 0. Never used
[    1.591119] max1363 1-0064: available_scan_mask 13 subset of 0. Never used
[    1.598013] max1363 1-0064: available_scan_mask 8 subset of 1. Never used
[    1.604817] max1363 1-0064: available_scan_mask 9 subset of 1. Never used
[    1.611623] max1363 1-0064: available_scan_mask 10 subset of 1. Never used
[    1.618516] max1363 1-0064: available_scan_mask 11 subset of 1. Never used
[    1.625403] max1363 1-0064: available_scan_mask 12 subset of 1. Never used
[    1.632293] max1363 1-0064: available_scan_mask 13 subset of 1. Never used
[    1.639201] max1363 1-0064: available_scan_mask 8 subset of 2. Never used
[    1.646002] max1363 1-0064: available_scan_mask 9 subset of 2. Never used
[    1.652802] max1363 1-0064: available_scan_mask 10 subset of 2. Never used
[    1.659691] max1363 1-0064: available_scan_mask 11 subset of 2. Never used
[    1.666582] max1363 1-0064: available_scan_mask 12 subset of 2. Never used
[    1.673478] max1363 1-0064: available_scan_mask 13 subset of 2. Never used
[    1.680382] max1363 1-0064: available_scan_mask 8 subset of 3. Never used
[    1.687183] max1363 1-0064: available_scan_mask 9 subset of 3. Never used
[    1.693984] max1363 1-0064: available_scan_mask 10 subset of 3. Never used
[    1.700871] max1363 1-0064: available_scan_mask 11 subset of 3. Never used
[    1.707758] max1363 1-0064: available_scan_mask 12 subset of 3. Never used
[    1.714645] max1363 1-0064: available_scan_mask 13 subset of 3. Never used
[    1.721532] max1363 1-0064: available_scan_mask 8 subset of 4. Never used
[    1.728332] max1363 1-0064: available_scan_mask 9 subset of 4. Never used
[    1.735134] max1363 1-0064: available_scan_mask 10 subset of 4. Never used
[    1.742022] max1363 1-0064: available_scan_mask 11 subset of 4. Never used
[    1.748908] max1363 1-0064: available_scan_mask 12 subset of 4. Never used
[    1.755796] max1363 1-0064: available_scan_mask 13 subset of 4. Never used
[    1.762683] max1363 1-0064: available_scan_mask 8 subset of 5. Never used
[    1.769484] max1363 1-0064: available_scan_mask 9 subset of 5. Never used
[    1.776283] max1363 1-0064: available_scan_mask 10 subset of 5. Never used
[    1.783171] max1363 1-0064: available_scan_mask 11 subset of 5. Never used
[    1.790065] max1363 1-0064: available_scan_mask 12 subset of 5. Never used
[    1.796955] max1363 1-0064: available_scan_mask 13 subset of 5. Never used
[    1.803846] max1363 1-0064: available_scan_mask 7 subset of 6. Never used
[    1.810646] max1363 1-0064: available_scan_mask 8 subset of 6. Never used
[    1.817446] max1363 1-0064: available_scan_mask 9 subset of 6. Never used
[    1.824246] max1363 1-0064: available_scan_mask 10 subset of 6. Never used
[    1.831164] max1363 1-0064: available_scan_mask 11 subset of 6. Never used
[    1.838053] max1363 1-0064: available_scan_mask 12 subset of 6. Never used
[    1.844941] max1363 1-0064: available_scan_mask 13 subset of 6. Never used
[    1.851828] max1363 1-0064: available_scan_mask 8 subset of 7. Never used
[    1.858627] max1363 1-0064: available_scan_mask 9 subset of 7. Never used
[    1.865424] max1363 1-0064: available_scan_mask 10 subset of 7. Never used
[    1.872311] max1363 1-0064: available_scan_mask 11 subset of 7. Never used
[    1.879197] max1363 1-0064: available_scan_mask 12 subset of 7. Never used
[    1.886084] max1363 1-0064: available_scan_mask 13 subset of 7. Never used
[    1.892971] max1363 1-0064: available_scan_mask 9 subset of 8. Never used
[    1.899771] max1363 1-0064: available_scan_mask 10 subset of 8. Never used
[    1.906657] max1363 1-0064: available_scan_mask 11 subset of 8. Never used
[    1.913544] max1363 1-0064: available_scan_mask 12 subset of 8. Never used
[    1.920430] max1363 1-0064: available_scan_mask 13 subset of 8. Never used
[    1.927322] max1363 1-0064: available_scan_mask 10 subset of 9. Never used
[    1.934210] max1363 1-0064: available_scan_mask 11 subset of 9. Never used
[    1.941096] max1363 1-0064: available_scan_mask 12 subset of 9. Never used
[    1.947980] max1363 1-0064: available_scan_mask 13 subset of 9. Never used
[    1.954867] max1363 1-0064: available_scan_mask 11 subset of 10. Never used
[    1.961841] max1363 1-0064: available_scan_mask 12 subset of 10. Never used
[    1.968815] max1363 1-0064: available_scan_mask 13 subset of 10. Never used
[    1.975789] max1363 1-0064: available_scan_mask 12 subset of 11. Never used
[    1.982762] max1363 1-0064: available_scan_mask 13 subset of 11. Never used
[    1.989735] max1363 1-0064: available_scan_mask 13 subset of 12. Never used

What is the correct way to fix these warnings?

Thanks,

Fabio Estevam

