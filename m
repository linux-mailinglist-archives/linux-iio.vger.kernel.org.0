Return-Path: <linux-iio+bounces-13955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F34A03F4E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A183A0461
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33641F942;
	Tue,  7 Jan 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv0irFqf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E474C9D;
	Tue,  7 Jan 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253318; cv=none; b=fSFq6zqcTJC3NFEdrRRHds9DJDuU65L7ELUuJK103vybwGoFACBOGObdzlRWxYZvirHn2lHwnQ1r2Zlx7+zvsV9DAlPoYuQzJ9iO64qCKl7V1+LL/U8kGT0etzaQudGboFIfLeKIkLwqv8BYshRhRk35ret6WJVPpd/RFVvWV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253318; c=relaxed/simple;
	bh=LJyapVwH7Re0juP396L+c/qdzChM9xKipcwffyp6YXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPhwqgh8tm2hZDwiUOTQy2wr7DPE9/oS+Tl0+BjOTY5JaNC2x/rJHy7kahANa0TxYGw+sBVU83NHedJ8yWZwSVrBjuKau+cs254+jYBWqoXob70V20DFJQjTXXJz9PtgzCX+tIobQ8Qi8pP4zubj5V0rdNY7UONErzgsZuh4xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv0irFqf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166022c5caso199230325ad.2;
        Tue, 07 Jan 2025 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736253315; x=1736858115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Twgqvf7djXsIRd4FCpptc6p5TwkjPiOmRb+MX8YbhMg=;
        b=Bv0irFqfGGeoqKC7vLKl+JPAL/wyuycHGoSf9KqxkzZ68qX20ceTdKCSAcT0LGKkkC
         uRfYO8crSZ3qGQqOgsuJwZTpwEPe9rS6NG5oxQrVkUYlx1crNJ3042lpqJO9r/eKpp0p
         d55hrABcnetX1fV4xH6LQg0a3Cb1fsXDQN78DgSSjp/JpXknjuLWPqM2uanIGQBjgLRi
         y/Dm+TOMCjpSs/8zaAIX4zyjJ6JhIZrhmW3q/jYQv073augqM8cgzwnhw/LMr+zs2tVD
         vXyCO+Io3Bli+IwdSDT/Kgsxgl+UrnSXgWirEak1gT0sKbGs2sDEOPDcc+bA8wMShQpD
         en7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253315; x=1736858115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Twgqvf7djXsIRd4FCpptc6p5TwkjPiOmRb+MX8YbhMg=;
        b=LJqw614t43AoOB4gR5dGDDPqYQGbHuL/dpc4v5TBzmHjfvkQqfGFUn8FwugLm0CdmI
         /uMLu/edb4XhraFRXGThx3h74INwdH3RqfTlnB3XdIufjnHhSOEf08i5HUbRStwrFr0p
         r55s5xLvAgEvOSXmqNRSSn+lYxW8DW9by7SxK4vR74SFiWFGh6ICsepXc5CXHauTkUYg
         JpiixKWKi5nixzphPmMHcWVfkA4NzEaKUqAaJO1Xzhpbsqz5d2uIDZJhN6Qz+rnw2N/e
         6v45nijFz4JGnfH4Rwof7qBbYO5zBLheAZADTtpLsShfQBVi9ph8QasOPtsplUgu6pav
         fafQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGql/jjGAkbasyP5KwTaA+9L993RDyshP6HSFWDyXYhDZb60BIUCB2ys1xcLVZBIl1qf5sO6L2t2a1H5tN@vger.kernel.org, AJvYcCUd8DzzefB6ba0kgRw6d1nq7sj2fcMzAWmpFiz71/WhBZ6gW0cUCrSXcwOr3c3glIuGUd6VoQVYy0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+2yNWoVfIoEIZ+Ez/RG9eMliatu/H/3sAcFnnYD8X3CVOQWy
	ZaiCBgDy7VDznZD5aj9NZO5yERrgEnbRIbp5DPzDCFydfVOLQsUn
X-Gm-Gg: ASbGncvGv1GUwo8kkM9PxqGk43+1dv14A2ruPFwfmwjnDPLmxV+eq4OB7VivHjIstjH
	gp6NiMIyhyeTf3AFe+RJfW9Xvaqc3ncbXG8Z6r16i8xXspkIZDJxS5pl1tc21OrBixMBV8yI1HJ
	4NYjRcssbQ5XFKw2y2N5E03QjO85U9/QwLW0fsB2xtNMV2p3hvV8vkrqeRBTzSAXcBYkZy5c9/s
	ztHAHC8WWUfT6vo2vW1yeRD/glKG+FgpSdZXwM5lZh27CdQzhTq63EFqPRu
X-Google-Smtp-Source: AGHT+IGR7QBuEbRPYh14CKjEcRbKrY1GMmexCpcSw+7pQzXMgAAmHfaVt/sTfsQ5xwMXT8DSFWrEVA==
X-Received: by 2002:a05:6300:6681:b0:1e0:c6c0:1e1f with SMTP id adf61e73a8af0-1e5e07f8a98mr88380172637.36.1736253314820;
        Tue, 07 Jan 2025 04:35:14 -0800 (PST)
Received: from HOME-PC ([223.185.133.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb9c9sm33419139b3a.155.2025.01.07.04.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:35:14 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: jstephan@baylibre.com,
	yasin.lee.x@gmail.com,
	dan.carpenter@linaro.org,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH iio-next] iio: proximity: Fix use-after-free in hx9023s_send_cfg()
Date: Tue,  7 Jan 2025 18:05:10 +0530
Message-Id: <20250107123510.44978-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder the assignment of fw_size to happen before release_firmware()
to avoid accessing the firmware structure after it's been freed.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Closes: https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602791
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index e092a935dbac..5aa8e5a22f32 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1036,12 +1036,13 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 		return -ENOMEM;
 
 	memcpy(bin->data, fw->data, fw->size);
-	release_firmware(fw);
 
 	bin->fw_size = fw->size;
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 
+	release_firmware(fw);
+
 	return hx9023s_bin_load(data, bin);
 }
 
-- 
2.34.1


