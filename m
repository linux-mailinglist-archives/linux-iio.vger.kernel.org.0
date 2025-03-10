Return-Path: <linux-iio+bounces-16650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2165A58B80
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 06:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B537169147
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 05:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB801B4F17;
	Mon, 10 Mar 2025 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCgdGdM7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FC23A0
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583063; cv=none; b=Ymh1rDb99HVlPexPsHlCltTcEUaxVIKUYJpWA6pd+OBLoJ8EdwdHsPT7kRTGWKd81A66WtyFBcEQz1T3PVvJB/58G+wbDmWmyQSwFQhxXkkw5YVcw55s7AFWa3Eq+wC4h37cd+LXPNN24URMMlH8F5nbUKgNNh81LE1ACNB/fY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583063; c=relaxed/simple;
	bh=q6NfNUNQBTSF91c9KKH16Up6ObpUIOb2BUFqTI50ERI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvWsqDHyYb+a5f6g2x46XRSpQQvXIQ+y0V9BYRy7APqeY2pgdk0OKykKXhQonWT5+QtQvFtEQCBfaOftxOEGbKqyBxDgjz3u9y19m9aJE+1saDEjVUCqsSkkkqx92QSJUX65X5A9Xy2n5GwQspDmkTrQXlaTvU/7oj04Yzb3mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCgdGdM7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so17873735ad.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Mar 2025 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741583061; x=1742187861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/cWYsfP8rkFy5bv2b9tinV7f9VP1wrTOoJi3iFN7uE=;
        b=CCgdGdM7FDAvitnTAtm3JY3PhCO+f92if4CKax3ynMqsbriEoF4hHZu5bfkfcuR1V4
         U9LpAMZN4mg7w3R+hVl0ILo0OBd1mZOUdjVkLF+5Ji8tNMgHStvR8bndCaJuVbk57vEi
         34QeDBJkAyU7Wss2Dcta8lBdYHUeeMbRZPC9yFOFRp4IekMLcWn3uYG+hVqK2hVfoSJE
         qTmrBgg5dwOeuO2KjNjzTRzQpeepJ7nm8mLIE2Dy4SxdpieomnvWrGIPYNXBHqOIA0WT
         3oykCIHIiyEnsLMhmIOzYZzGjq0bM2P7yUzZC49pDoq+edZUC/wTyItLR5sNZoDtJ5na
         2SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741583061; x=1742187861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/cWYsfP8rkFy5bv2b9tinV7f9VP1wrTOoJi3iFN7uE=;
        b=HuGHtbO8s4d91FppY+PCBvySVlJWRl91A/4YE4YyY3l7EHDLbqdMw+onWguie4KQSV
         di2WNkK6dGg0Wrj6bCCmg/3A+5laZbteZYjXX81yucZdWM1BLbvxvuWE5bSWy7UNMSwi
         pTNZoSiQ591SnEmaDK/Sb8BDJIOjiJrF0haOMij9B8gKu2RwZcmzG+SJT8qoPOIkZXxz
         +JwDBnN6R6YhrHGR+lAV8rPcjgGE81xvE6ltcFX/6wXUIZEWD+6ZmH8mD1Qicjh3nglc
         SDKomYgEd9dgSKMInQBdSiuq6lhwUCNIEUrPcHciRenZ7d4xrjQe/WWdkpvwnrsh1H6W
         EA/w==
X-Gm-Message-State: AOJu0YwaNrAwy5Xxzl4x7I+oOTXCqjyEXysox1kpNWGFVzutyDExDW8C
	kIJv3cMoto/gbJE9oDSFBG+uLjHGO5h0OW3PXpLGJlgfz9SVOh5l2Y6Ey9Eo+7X+X/x6N6CD0Gh
	JF9BxQ/5m0OLCbH1dYpy94dxvCLZAZ/NdKyRQ2A==
X-Gm-Gg: ASbGncuIvn/gXFBFgITIxoKmMViKm+CCQ08UtAKBtBgIYfqsSpbx+FXsUixbtVcZIde
	4aN0p7m8eOuipozPagoO2t44ci70xVEdWrtnIOTu6PGinQHkl6xNbXFbckGSuyqjARdLtIXZQZq
	h2E2lsStBM37iCARbCSlagOh3zyQ==
X-Google-Smtp-Source: AGHT+IFNWP3DNO0vAsmLEwSBQUgVWWfSTh04tx2ie94URN9FyEbho+RFV2mDwvBoGuMfhgz/pSneUfS7ubuz/PzVcO0=
X-Received: by 2002:a17:902:f68a:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22428bdb6d6mr183364745ad.38.1741583060963; Sun, 09 Mar 2025
 22:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
 <20250309162637.6937c7c6@jic23-huawei>
In-Reply-To: <20250309162637.6937c7c6@jic23-huawei>
From: Prince Kumar <855princekumar@gmail.com>
Date: Mon, 10 Mar 2025 10:33:44 +0530
X-Gm-Features: AQ5f1JqGrYgCQKfcc8hvVNhMiyWv-2TH0FPjSUuCCzMXfKfrootJwRl7d4Ew61g
Message-ID: <CAMmuoAJy_GPL-7tfbrgH9U4T4UvUiDoHozw67BqadoV_nAJXog@mail.gmail.com>
Subject: Re: Proposal Discussion: ADE9113 IIO Driver Development for Linux Kernel
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for your valuable feedback! Your insights are really helpful in
refining my approach and ensuring alignment with best practices.

1. DT Binding Flexibility:
   I initially considered making the DT binding adaptable for similar
SPI-based ADCs to potentially support minor hardware variations with
minimal changes. However, your point about maintainability makes
sense, and I see that most existing bindings tend to be more specific.
I=E2=80=99ll revisit this and reconsider whether a part-specific approach
would be more appropriate. If there are examples of flexible but
maintainable bindings worth looking into, I=E2=80=99d appreciate any pointe=
rs.

2. MCU-Assisted vs. Direct SPI:
   This was more of an exploratory idea rather than a fully defined
plan. My initial thought was to assess whether offloading certain
operations to an MCU (e.g., pre-processing or buffering) could offer
benefits over direct SPI communication with the Linux system. Given
that this isn=E2=80=99t a typical approach, I=E2=80=99ll take a step back a=
nd ensure I
properly evaluate the feasibility and trade-offs before including it
in the proposal. If there are existing implementations that explore
similar optimizations, I=E2=80=99d be keen to study them.

3. Reference Drivers & Guidelines:
   I=E2=80=99ll definitely check out the iio/dummy/ driver for understandin=
g
interface testing and take a closer look at recent ADC drivers to
align with best practices. Also, I=E2=80=99ll make sure to follow the Linux
kernel coding style closely and avoid unnecessary deviations.

I really appreciate your feedback. It's helping me reconsider certain
aspects of the plan to ensure it fits well within the IIO framework.
I'm looking forward to any further insights you might have.

Best regards,
Prince Kumar

