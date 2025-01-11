Return-Path: <linux-iio+bounces-14120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB7A09F3F
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 01:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94F33A119A
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DA63D96A;
	Sat, 11 Jan 2025 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ptGPu3LS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1879D2
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736554951; cv=none; b=IhbMj+pQLC0s7GZ9irK/Yyiv0q36Fy8uWMrA2wQ9buTIPndHdkKumrw7dx5CLa6mmv13cxPd/TGVfCyofIflaEZwMn+kT9dbKo3G8ckYUT8t0jkWd4TiPx39dQYgXF4KCRpviye9+BSgq60EQ+3OONi559RFRIPwFa52zgUYZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736554951; c=relaxed/simple;
	bh=wvbzDL5AhiGelEihmC6YBvaJBEJ1CgebykByFmweYMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWyMxVwEzkpvw48rpfIuTf20F3aAw40UkVk2qMCNGoP9UBUHNi6yO0/FudkQQHEUaaklatnoxvXmE8N+Hw4lyqWljCEjbsM+OqvUmDEu/hQZeWJfxy3cQejGV5exPQ8+vGmvojgedalUZ9jQt7105uPR/2Ndzl9Lpl/BcYuUCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ptGPu3LS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb98b3b63dso646821b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 16:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736554947; x=1737159747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW8e0hxsXp+vQFvDPfQqx4iFekcjRNa9r51bkAvubqg=;
        b=ptGPu3LSkG/+ZmiGm+z1TrT/0lTu4Cp+zZ1VBrlEJd74Ycv4l76vK2VBq8IScZBizf
         yqlT4fA5mnVKwKXgkVFFjeGSy2COVtZLQoesTD50pIctGhecXNMk3xfrzdlan13O0rsj
         tBqTnvyLOv+QtXWZkvDqOHtjVWkxKq6opUK+hTLo4ALHMUNe6qVa+FTvNquf2N4+8gbY
         8LoVHzBwBUz1zFljbuR/0hfLPYCLw1WaKNz0sWUs2PqOYIJC8PU+CnJ5EK+z6TGHYgzB
         8q2Gpw1VMW3mDxDhcnxjouBE02ASqK3aNjvItsMkhhgR55fBEuIllSSsuvipJGPbCIRY
         45Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736554947; x=1737159747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW8e0hxsXp+vQFvDPfQqx4iFekcjRNa9r51bkAvubqg=;
        b=T0mPsIOrswJT4rp93seuY/43lano/CLSJv1aOiwU9OOvDEi/IwBsUMNkYKNcw0Yq5I
         LQjY52POmEIipe6lY6ltrnC2WWOJDpyHaOGHQGxnisOMdTfvOtIsfhDqf1RNkY8bH194
         YVBsvyF+CHfWkrFcZ1NjSBZmyjJ7JBdQ8wF2jURW1XGxPmtT2ed2Jw7owYJ6o94v5ZCN
         uuQjHi0ee37+dx+JwmwJvo9Xnn9CTW+I9EEiCi5my5TWXf6TgOlxZ+Ydu+sR0zJXMM+A
         dFReTFkUg2YEAjSbT9b9fT/5+8f1VRQeGJjWYEYkv0GJ3/aKhdIJF41/zWMF4V/hGPF2
         aE+w==
X-Forwarded-Encrypted: i=1; AJvYcCXrY9ePC12olaH+/TPw+6Ai7C0CG4VqfLZ9nAAcckPkD6kDFwFuc/yg6NJy15qT/4J0lSKaSz1a4FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1mxiTHk+FpBqP3eBBCT3fFiImWEq/ySavyjO4C9RKu9iA4k+
	2Pt8qG5/uNLigmgWminYmn+fVrwcF5B3YR0cc2lcajJbaa3sIqno/OxiAh8YSuQ=
X-Gm-Gg: ASbGncv9gVrs4K4U0AksnEv2OZGIwQda1n+BiOB/Mo4GBNjXrYhcfr0Dkg78I+t9T8T
	OYqRnSKygwnWHg5H9VBXDm3wZM3utft8mICi/+i8KBniv2ndZoXvALdJaaHbqgOtafoAav2pGUv
	XI/Vquy+kHpS9KDNxhbng8xA7FhoiMX/ZYuwTO7arN2h38VvDUYC1Jki9lC4jpujLP97nx8eVhf
	DAIajdDxfFV2s5ipyQZhfkCzhzWcu1ZSTXgqLKq0YvNE/qFPmu7TJvebDso5lT7RZb9HH3CwzCV
	oApYZD4Zfx6A
X-Google-Smtp-Source: AGHT+IEoNoeWncNV9t+kRIbcV6xhg/XvZirmBilfvjPRkU868V7K9GDkUMtffvSsWmEZcUZoWo/hPQ==
X-Received: by 2002:a05:6808:1996:b0:3e6:3a82:f790 with SMTP id 5614622812f47-3ef2ebcb1c6mr7727253b6e.6.1736554947325;
        Fri, 10 Jan 2025 16:22:27 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723186280easm1228941a34.59.2025.01.10.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 16:22:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jan 2025 18:22:05 -0600
Subject: [PATCH v2 2/4] counter: add direction change event
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-counter-ti-eqep-add-direction-support-v2-2-c6b6f96d2db9@baylibre.com>
References: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
In-Reply-To: <20250110-counter-ti-eqep-add-direction-support-v2-0-c6b6f96d2db9@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Judith Mendez <jm@ti.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add COUNTER_EVENT_DIRECTION_CHANGE to be used by drivers to emit events
when a counter detects a change in direction.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/uapi/linux/counter.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 008a691c254bdb49b9c922d7591e755e82b38a84..350b45d616bb102c16f8b60e9039272db20d1be9 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -65,6 +65,8 @@ enum counter_event_type {
 	COUNTER_EVENT_CHANGE_OF_STATE,
 	/* Count value captured */
 	COUNTER_EVENT_CAPTURE,
+	/* Direction change detected */
+	COUNTER_EVENT_DIRECTION_CHANGE,
 };
 
 /**

-- 
2.43.0


