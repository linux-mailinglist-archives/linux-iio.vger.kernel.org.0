Return-Path: <linux-iio+bounces-24761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9FBB9888
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42E03B4E04
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2A289802;
	Sun,  5 Oct 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr+zrnfe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460281F936
	for <linux-iio@vger.kernel.org>; Sun,  5 Oct 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675709; cv=none; b=lIGCDH6cc9EpnUn7iT9iNO8KTaH6UaAXNfwWE4elvueQw0KHod2za/L5LFL8h8khttIFpqEYb/JMcQmonVD7+6JcGDIgAihDuR+s2R5/Afj1chgUe51txxjZRPuuh9JBdQkvWuaXqfcorS5PTfCGE1djd9PdoRJ3aroT/0ssU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675709; c=relaxed/simple;
	bh=oYs+5FKiuqdmr562c6Vj8WoQyeELsGW1c4ij3xz6igY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH4Ss+3GzthmLLKuG4UPyJLyb8cgxY7AGUgYLbW533zRvtqPYKVL1wV/uqq9nlt5rrwlllcDtZ8TleNKUyR6Q2DWDyJHTEHjHDCni+Ih767vVhKkBObaWmnhhJoEaI6LPlrQS09MIov17ieToagkIr6p0TO3HwVeIBlxDCAHQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr+zrnfe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78ead12so704330166b.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Oct 2025 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759675706; x=1760280506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li8067XAjYgU1XijTNdw2M26YBT7ug0s2F8502fWQUM=;
        b=Zr+zrnfeTY8qfELhkHJ34o4rQ4QIWst4RyY1TO424iLJGJYPE/R7TNwjzhHcTqTWKb
         yWTIQq8j56PHMMJ/D/ksCziFTiuOy1jB1bVvXbPHz3fclYltRNYwdDTWgWQPr1Zf/8g6
         sFeTaCQrMobN5M36AhsrMO+ElQ8xjdg/3lPAovEkTj8HUajYOKIeVwEtEmjotDF4jqx2
         ZsBZMx745VQIJnuw2BP9UOBZQCY+QNbAx+T/onhEH5efEccc2ssVfZooHUVhZ+LAjwV+
         wCtbH9kvofrr5u0+ygfbVXrAsWBCOpNprKUJI/eqbqMRz8V+hTTkIZQLUTYfEaiU9QKu
         4tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759675706; x=1760280506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li8067XAjYgU1XijTNdw2M26YBT7ug0s2F8502fWQUM=;
        b=GGKJUpqUeynijAplnztNhDctR58Vn1Gat4MW2nkzahq1NM2xtw07QsE/mps4ZzkidG
         yQeI5Ng1c1/dNHUW8yHfwtXzrpGYbhqR0BelqZpBCQjeDawRWeqPw0QLvbxkyvQWIR1q
         kJlT+SmpeeFO3ggkAO6JPAE7SWjoCyBH6RYdchaLhEq+lNf3CBBbD/xIqMDoxI1awRz9
         DAJWxYj6zbny7F48cqtpVrg+tTdpOCVv60vGiyTua4wI6TNU4+99qbf5lGMotjD3nZkK
         OFX6CBIFJph38U+Pf4E6g6aXq/QMoAOltbFP9AUt2rnvjUHb2WEX465rQKAS1i482vP7
         076A==
X-Forwarded-Encrypted: i=1; AJvYcCUSewOD43ERnn1mo/ricPS4vCM4aTBGyCqVw0ojzM1dKG/IzVT2Vass/a8uMJT8Zh4nTaCNtQJqCTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHEOLe1lTDFZKmuT3rRUE+kucY+9HG+Zc0OU9Vdu08itzULI8
	lMiBc+MdJsAURathkLt/emRQwb37yNupKW344AYtwcy4J2A13KnBy4Ko
X-Gm-Gg: ASbGncuox6/7qoFdqPqlCMfgelc4CclSkzdfpdomaBsBHg79rEGHFjReIavQNNdSFBj
	E8agwo3hShivRLRm+9UIlaSBjm6W31TwB00baNF+kQM7aTXWmZKN2z6CWd6fcvSxbH1upNc3GaA
	9ypf8Y/BMURDTPosYNqvFBWlRF6fKRO6S0C+raFVDTi+fOJ3uwNQyTPSmyzgYMuHgA5bJn9Qc09
	yP8ehmTQhgDJl2awYPJ42b4xn5Ilbl+i/Wz0LYoz0WjqYMEhOdljndkxaQV3FHbQ7VE/2uhtnmc
	xCn4fQZJUBY0Z2rQ9n3hTgiSpvBLGGL4Rde2c5gvYeZUghmLLm5+qvPpbC1eWqIr5eSbEUvCo3l
	5wxHgLQri65apA3J1yN6auaylf4HscuAXFhxS+I5TRA==
X-Google-Smtp-Source: AGHT+IHKY9rvvpejdXZNJCEHfcSPdgdirExQui8GodmpNdb1/H4E+TX0nhVtgVx9TLmitQ2vz/my2Q==
X-Received: by 2002:a17:907:a088:b0:b3e:f028:2d57 with SMTP id a640c23a62f3a-b49c48a532dmr1314634366b.57.1759675706342;
        Sun, 05 Oct 2025 07:48:26 -0700 (PDT)
Received: from ASUS ([182.185.168.104])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ebbsm925246466b.7.2025.10.05.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:48:25 -0700 (PDT)
From: Taimoor Zaeem <taimoorzaeem@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	taimoorzaeem@gmail.com
Subject: Re: [PATCH] staging: iio: ad9832: move ad9832_platform_data into include/linux/lib
Date: Sun,  5 Oct 2025 19:47:58 +0500
Message-ID: <20251005144758.190457-1-taimoorzaeem@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100548-stereo-patronage-408a@gregkh>
References: <2025100548-stereo-patronage-408a@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> No, this should only happen when the whole driver moves out of
> drivers/staging/, staging drivers shoul dbe self-contained.

Right, I see.

> Also, why is a .h file needed for just one file anyway?  Shouldn't this
> be part of the .c file instead?

Not sure what's the convention here, but yes it could be part of .c instead. There is another .h file in the same directory (ad9834.h) which is basically empty. Should we remove that too?

