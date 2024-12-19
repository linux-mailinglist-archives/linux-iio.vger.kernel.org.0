Return-Path: <linux-iio+bounces-13694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DDE9F88AE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 00:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE071169E6B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94C1F8EEE;
	Thu, 19 Dec 2024 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwbYFZcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7FE1F4726;
	Thu, 19 Dec 2024 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652078; cv=none; b=kjpnF9uD8aOGGxFrKZZ4cUfzaTPib/nKOkMUr+MGZlI8fcIFc/jq5NkPObzXqO7VN+jwbYlbPKhqQmb9Zx30OlSJLZDEvCf9oXFVJN0QA4mz2zvAtjF7tRbGoqO0jZWBsbmyhBfeiW4hRGlXaT+xUxsbLFgM5+zBJmY3JHuUwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652078; c=relaxed/simple;
	bh=7oB9LOSeFycT9I/8bD9O9Th27bcRLD8q4Nv3vmPKypA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru1Jbl4oZvTMunRAL5QeWiPu3u/J9JtPu+Jgihkrsce7960FwrYCKXIqX97+e9wMabWMJ+KmlTHl2MBdDAgDUAhoKVFc1bR6brwLECd4gE4qNlCMerZlpRdVAvdCTmrVBAUtuzljFdSlHsQEBPwvWQhaTq/3hIQXMygJMcpkJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwbYFZcB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso212756966b.2;
        Thu, 19 Dec 2024 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734652075; x=1735256875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKavMMwNKVC9ev1USvalc/SFe3F9t+NSs2JtWlS/i0I=;
        b=bwbYFZcB7O3y1Wy49Kqm7AMZC517UArInmsWQ7QhnBWdYHayU+mA5XVk0PYjWmEtB0
         nrZdaMNPDzvY/9YNlzaIn+/P175KKN/ddpE2XGxYvcV5AGp7rrNCRc8bZhLXz6GdfTgp
         FDduCM9VLgP5QfsVARGwvNHCLCqH5aJHNO799aKoIEp2kSDR3q2Wt0sqZ+XZV3k6Nt4l
         dSu+LflqDNY6L+FLBpCXU/pEWgNXLlJ7bbpLEpyAeT8XoybECeFR56wHdM1enPZgrnvr
         XLOD+Af0zN3SnKA/LfrBQP/s3Jvjj2xcos130QGeB/VAyPnC3AX+sRXlIqnM9sd6OVHv
         TUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734652075; x=1735256875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKavMMwNKVC9ev1USvalc/SFe3F9t+NSs2JtWlS/i0I=;
        b=fzq7xxtOZVrZJBYMkQc2xeDqlyXDuR97pjny6KitXEm5fG2hxUJuKPhhd4I+7hC8Fu
         eKCzCoP+S8A34vsPwRlCKXwlHiwZNngW4r3mKggBAd2MTfHUFB8+/MIc0m3CYqLoUjm8
         JJB9KUlAcoy2tIlXjyVW9yLGLYKIy6Ztz+SzXcgmh/1go0oFPaciTTHykVYrdDEwTbEt
         0gCpxWTtyS0sjz80Akfin8cGoqFcF4lGxjtlQSdiK0iZfvfwcL1/80o0RR+ranpXmDkI
         Jxgx7QX3TfN5Es541BXoJnWTWyZbpdknXbSsEdXQeYSfRv6SYG1Cwl60eSomj5c8oMyH
         kteA==
X-Forwarded-Encrypted: i=1; AJvYcCWCNhnDK7BM96UkJIA+oeRyxIQM1LNxJ3jU8voeBsG8Qg/t+EY7L4Dv7i+9Ua/Jpkh6MgZOWP44rV6K@vger.kernel.org, AJvYcCWVv0ciowTqvNJ9/vxGd8dqankYyY359HG+FzFmS+zGGs4DfuTOscWuHXkVoZjzxwrMYbQjQC1V/X6wdr+c@vger.kernel.org, AJvYcCX3Ts7N/BH31jUAJvWEdJnKfvFyWAXSnIGNxj0gxKePO9R4KM/3gRREzHWUMOG9TZeCCiTRE/P6qtWb@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwgBuH2rBN8KuLZhLuH1IKs70a3VU0+dj6kj4joazKuchi9U4
	rPmcMqMJspZ71ENAd+paoBt2cIkts0Rwio8CbO60djL2SGz+dshH
X-Gm-Gg: ASbGncsDamZgWMBfOf3yPhxvnQZdBLTOuN7Dbd6K0+26F7H18raYwO4TYDNL9wW2TpP
	MnvzJrCBcxCMLdTfDR9mELTCIyaTh1PFzpBrXTyG/17ED/Wg6QHmAUM5CqnoE5mjlK89FyGb+71
	nXd/i133HZzCTWPMwQhOizCNAlWTBv6aMJQEo4JehCojg1ZKwi3n9QhNWKZneYJBK14DSVzrvqg
	t+GqCAsh+3f3wsXK1GJ9D8FwEm13RntPhg7ci67T0X9apTvc2xd8JnGOBtZvYYUvgKi
X-Google-Smtp-Source: AGHT+IFWJWO6dZLB2d7q+ZewIDF469dzx7WhPjmD520QX2NYubWS7VyoYbxHFg0Sl0FfjJGiQkTruQ==
X-Received: by 2002:a17:907:948d:b0:aa6:a87e:f2df with SMTP id a640c23a62f3a-aac2ba400c6mr55916666b.25.1734652074672;
        Thu, 19 Dec 2024 15:47:54 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:6db1:ccfa:1b4:55ac])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f076d1dsm113244866b.204.2024.12.19.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 15:47:53 -0800 (PST)
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
Subject: [PATCH v1 2/3] dt-bindings: iio: imu: bmi270: add boolean type for drive-open-drain
Date: Fri, 20 Dec 2024 00:47:44 +0100
Message-ID: <20241219234745.58723-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219234745.58723-1-vassilisamir@gmail.com>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing type description "boolean" for the drive-open-drain property.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
index 7b0cde1c9b0a..860a6c1fea3c 100644
--- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
@@ -41,6 +41,7 @@ properties:
         - INT2
 
   drive-open-drain:
+    type: boolean
     description:
       set if the specified interrupt pins should be configured as
       open drain. If not set, defaults to push-pull.
-- 
2.43.0


