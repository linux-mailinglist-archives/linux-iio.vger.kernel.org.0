Return-Path: <linux-iio+bounces-19571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB9AB9235
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879DE171F19
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA628A727;
	Thu, 15 May 2025 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIf+ue6d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493A27A461;
	Thu, 15 May 2025 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747347080; cv=none; b=LZ7nJFkxptTky9FtmUXTn7dzEa9qq3AvGrSUpWDLNP5GUSxmaAo3OA7kzsN0hR18Qh3kTNvkB8cTSOQo6VKMGZUSbYRGjf5M18PeuaR6NJPIiO1p3D+SnHst0ZmRkzywGfxCSZV3P/T91vOhnP8uHIxtVcNe69EDUYaTNMpJpJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747347080; c=relaxed/simple;
	bh=ozrPGHhhXZw0L6ZHF9peUvS5ENd7nuzyI5gF/2CnPS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfQPflUj/TsSstfp5MC+z0eSK5fIYg3+l1Ds/igwZJR1EVJkxreJswzXvSPP6xmkY1+fMooyrBYqrpO+6TCgFLeiUPKs8P8w3uTgBCz54vkkwnY5CDsmTQj+3BcjPfzQzJkf4ZxUHa75yxYw91W91p5/EPDqOAb5GkX8miwxt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIf+ue6d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e331215dbso19255855ad.1;
        Thu, 15 May 2025 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747347077; x=1747951877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozrPGHhhXZw0L6ZHF9peUvS5ENd7nuzyI5gF/2CnPS0=;
        b=mIf+ue6d9wAx2huZPVVys29S86ERLuJ3f/RoYIEhpD+pR3RX9+BEv9FMDa5Tv7+3nO
         0DmJ+mtuS4BRs7YKgp8nEqXA9/9fk6Wr1by0Mse7eacRpWzsANIP+hVqH/+LpFp2z3+q
         gS1AK5I03nsgbR95DOMbVqEkLntNOccqsRTZH/KCZo7X8yt3Auxj1QuG+Hqf22+AnqFk
         EGUtWC0iZOOFEPcTAfdP/dGfLYjbvjZ5CNzQK8G351UbCchaDo8jxbaPCZOvlakm0hAh
         2ntuXdzMBKMvpqroKvVjK1vxgqZ73os8980iCjOpu6eIbt6pvtGeW1TvfXjqb7/jPDWg
         JvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747347077; x=1747951877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozrPGHhhXZw0L6ZHF9peUvS5ENd7nuzyI5gF/2CnPS0=;
        b=VDYY9EjZBFNVizWSFhGf0aDRKmOMVWhwJLZYuikGPHB1vHZqAGJaCjH2GGy+AejYBQ
         lk141tcIEYyRw0PGYTVtt9/EnQXm74K4YIWWV9jAJ7pkwaoqiK90DtD+CqFW9sLxCNP+
         NLRQbjT83Q8z8GmomEzwHEbTbOmpNejWgJDZCJ+3U8AH6Nb4YcwCsp0h8YsuYGgqtbOH
         OS8td9ah0BswoGRjZLQ4ZEP9LIi38ittT2ekGxV1la+2ORZxF0ccJdWgQOsxGeivsFRa
         NFC7fYtrzsvoNnlrfpNrtWvAUG8+Yi2Sc46eo3nfDsUB3SkmsiVJkKzK69qwMX9VDNZM
         +dJg==
X-Forwarded-Encrypted: i=1; AJvYcCU2TGQorZ9gJ2xLsTms44vVIzcVwNNgwpXVwOAG5H+iK2iKZefMAF3y9TwBwGysZnhTe866PM6192O1@vger.kernel.org, AJvYcCU9c3imzOvA8pXqgJDwocJFTGRR0X5uFQcIDaL3byf6Tp+bqWPkuIys5oNqh8G1tQZq59dovPb6EjT3@vger.kernel.org, AJvYcCUsFBEZzNgXmvliyrNrhTZ+/3KEfxFelrdVKjpY5HLiiqDbjCQgoAXRDYSYxgzWWd71egrbyXIntT4LuPt6@vger.kernel.org
X-Gm-Message-State: AOJu0YynVXskWWBhzcRJCvnabR/pYH6iDPeXedzYeJkKP/yDbaNfCaVr
	wzYti9lchNxm/t9hptYTtAAemMbszq7+q8IEo2dhqhhe7l70G1MIOfNm
X-Gm-Gg: ASbGncuXBJ/ywDtLiAVTORYdI70rtcl/qhPDDZ7tC6Qst+y0YVZe6h71Hpr+AxgNZQg
	O1L4HBDKBFm3/uU2SqGcEkl/LCJq/DRB2VWMNajXi/Yddd0qmjztp4+/lE0ilFLI5eHJCC1+LJt
	+YxpLkDZpNaXaPx2FQlZnHHsZHFPLo/RSfMVmdvi8ROCmzdk7SWHthy7K2GJ4BkMciP8rFCUJcH
	WcfKtPyjxRUHAkEKkXIX116ajc+ac3j96PPVA+BE37SURQPjKRdz1hvBj25DZE3MwHZCkPI4Rmb
	oiH9J6l7+66vN64EnIVUVbHkpFmlpapTLB+c+JfzR7548MnA146IZ1FMMZFewN2mfYjk+dqzLqM
	=
X-Google-Smtp-Source: AGHT+IHupp5dQwBMrHVA3mbcMokDGksT6a8PcnRWuzjTVilf5Lqi6Jax0NBE8nQ64YewyA6rRCx/tw==
X-Received: by 2002:a17:902:e841:b0:215:58be:334e with SMTP id d9443c01a7336-231d4d10064mr10994385ad.10.1747347077135;
        Thu, 15 May 2025 15:11:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4aca2e1sm2675105ad.17.2025.05.15.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 15:11:16 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: rodrigo.gobbi.7@gmail.com
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	robh@kernel.org,
	~lkcamp/patches@lists.sr.ht,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:gyroscope:invensense,itg3200: add binding
Date: Thu, 15 May 2025 19:09:58 -0300
Message-ID: <20250515221108.3890-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <59220742-18b1-4704-bb5c-8b79f0099139@baylibre.com>
References: <59220742-18b1-4704-bb5c-8b79f0099139@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Also just noticed that the IIO mailing list and Jonathan are missing
> from the CC. Need to add those to have a chance of this getting picked
> up.

Adding CC since I`ve missed.
Tks and regards.

