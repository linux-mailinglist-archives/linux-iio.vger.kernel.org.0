Return-Path: <linux-iio+bounces-17595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C028A7A4A1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF49E188BF07
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1A24E4AC;
	Thu,  3 Apr 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as+kaVTg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF001EBA0D;
	Thu,  3 Apr 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689081; cv=none; b=hsJb0/1pPwAWKPhHIzJC3rjrwE40xtkACaovry90r2YVgBspypIRS1pYa2ffSjkJHOrGKVG43au8JClz26iixpTd1gwEIN7xazXdq0gNAaY+bV1V9woGL3r1opXa4XCTFn1yz2zIaHyEKVetgflGt4SBHlnMGnlxFg+P+7muVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689081; c=relaxed/simple;
	bh=F67a5dXXrcGfkmcFk4oIAAW+/52cmKN0yQ/ciKbD5YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMFbK/ZxiQ5jmYhB0hqT4qM7xeI+SESft3/h3L8/5pE0WtBgTBnItpcy1lkZJt6QC7we9xpUStBHmIr+2tAzvmKKgHcj2PKFYcX14RtuYPUVzEbBYBFeVcIkcQE8oeRIYAwhQzPL+/lzFE5xqUGmguaUcJHCvw82SJpYJ73j4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as+kaVTg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso680583a91.1;
        Thu, 03 Apr 2025 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689079; x=1744293879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/0iVPu/GSHg3jpVHmJjARAeQhLRDDNSLd+1ENg2B6tg=;
        b=as+kaVTgTgJpQPrX0Y+/+7U8KRLpS8DgPh7INs7DHFYMlHVy5V+N6on74JH3EdMuqT
         p637qKU7Xa975lo6qpMcwAZUBMPBib79NgXrYlPmat1e28+wsodi++6raLBBnAFSaIp8
         E+zu/miLIag6NPvXrAVaEgtkFYkDa0JuaxHjiPQHG7HAH7/iRjJ/oj8YkDuhtJSb1m+n
         6L8FHmLGmi+12nTJQ6POBZxBdwwhwsW98+kIgCjT1PPNpJA4o/1tmfrt/4jSOpFQAK2D
         w5aqBENNl4kNTbEM3TqCeGAXZkWDwHWotFdirsRkwSBR44VYhoRE3GMDKsuypcoT046m
         RDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689079; x=1744293879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0iVPu/GSHg3jpVHmJjARAeQhLRDDNSLd+1ENg2B6tg=;
        b=wtwAgo5SFU9n1bAUl9GFc7aKycux5BbelR7In9q1yhVu4losQy1gOOnZfYWxq+P/XF
         SN1GzpRX0LxZ+uxsDEFCqTN3cxTbcB8XSkvZbMoaeHefL0BUxsdCIEGkwEVkLL/3JO+L
         3a6+C9cHkZA/qyVH+x1ldCBjBmdFul4seRB/tmlh+kycaaNaXR3GCjclk762nybMUmU2
         eyXZJJWK/UxU6CchrmUi/lZcZluxranYEGPkMNm95jiiWKFdQYgBrHP8Ko8QRiNecoI3
         jmPm1M5abrn2gw9Azn3iGJHZRRFu4cX1knlqOFsIeu7FgCtRmwDxYeQbSylgjTT/ASri
         M3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW7zIpGehtrsW5zKB52h1Rio7DKljXvgjkZIH3ZQn1Hi64NoIQlRDbhmqIEDOKB2QdMfmUokJEUoSGQ@vger.kernel.org, AJvYcCWxzkKMrC2KgUoJgEc460fAC6mCZ6R4JyZsZ2G1v68FVyNgfq0eTkgFnWXj94M1LTv9HA7ZaX7Md7I6@vger.kernel.org
X-Gm-Message-State: AOJu0YypziiA6qhwMJWTUXZevK9eWZQS3YA75wzApiX+eX1qjpy9MxkM
	L/2tNY6ZbpAaE2clzxH3MAwp4VJfQMEjvf4cjAcX94Z/LPED2mGp14r7oDT6+/2yB87uf5L+jQk
	ylWiv4nBkU7CD4ET1tdIkfZHaX/GCrT36rZw=
X-Gm-Gg: ASbGnctXMUaQQIfsdUbgA+8fToM5eQxM8ybuKbxsV1PG4gLr3FVKHGif7QESHLJvK8I
	EyjmI+CJZpssXkwShVUXQwCF7oE7aRDYiV2h6GgncoUFji8SUCKu/UFqSWW2YPZnSCv/fSIM0BD
	wC87Gc7buISLkXd/JXtxQ1YSbg0yg=
X-Google-Smtp-Source: AGHT+IF8iS8X8QBJJtlFWbHAT+zrX1IV0ERhRDKMQgQQnwuKhaPKh7RRiF7+scx2WGUzgRilIxuxQu2z1b6fNWpelLA=
X-Received: by 2002:a17:90b:3a44:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30532163db8mr35686498a91.33.1743689079367; Thu, 03 Apr 2025
 07:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-5-gye976@gmail.com>
 <28f4a7e5-ff96-4c7f-9eab-6bf358f19007@kernel.org>
In-Reply-To: <28f4a7e5-ff96-4c7f-9eab-6bf358f19007@kernel.org>
From: gyeyoung <gye976@gmail.com>
Date: Thu, 3 Apr 2025 23:04:28 +0900
X-Gm-Features: AQ5f1JqsJQ_Fb4RlxCPG88jgR91C_jP-EAU5BGcqFDpz5nXoQUk0Q0IIbuLBcvQ
Message-ID: <CAKbEznufXvgTzUJObJGe05GfAamAsf+0dS7zmsEzzO0Swc4tPw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Krzysztof, Thank you for the review.

> > +     /* serdev receive buffer.
> > +      * When data is received from the MH-Z19B,
> > +      * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> > +      */
> > +     char buf[9];
> > +     int buf_idx;
> > +
> > +     /* must wait the 'buf' is filled with 9 bytes.*/
> > +     struct completion buf_ready;
> > +
> > +     /* protect access to mhz19b_state */
> > +     struct mutex lock;
>
> mhz19b_receive_buf() does not need any locking?
>

As far as I know, receive_buf() starts from flush_to_ldisc() first.
But this already has locking, so I think it's fine.

Thanks,
Gyeyoung

