Return-Path: <linux-iio+bounces-8946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2838967BB7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344F4281C35
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E99183CA1;
	Sun,  1 Sep 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eE1lP7bm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9222433CE;
	Sun,  1 Sep 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725214633; cv=none; b=TL21qoBEdLH6/MaoLkucX9Am/JNiCz2XUHimRybE8H3H/QpTjjUL3mO/w/b+6PJmvdW9vM8Vln/V9eX7ICMsBFGKhMKeW3xnXJlF4Z5jEeyNMG1Vgjc6oNwEi6HX/efPXcyvIiUW8wzZTJEbX32GJd4h2awMwP019htpsGMOYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725214633; c=relaxed/simple;
	bh=JlvO8lYcXIn5q4W39SnrcPTvSyxJR+Ym3ZZqAzEHI0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVBe0UjdLzjhJ5Wy/ldCxt9vBBWWWaA/QY9mVNtI3Ibb9wJJVpdY0y+sdlQqXa15YuYbXzT/SwFXDJFJ6eRCXZxCX4QJKE1iCeMsUljH1Edk19d6JCwPJJoE2YKUjSMIqOCHQ/epB0eaJmi/jZYnC75DS9HPmBIbKS7vUocE+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eE1lP7bm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725214615; x=1725819415; i=markus.elfring@web.de;
	bh=JlvO8lYcXIn5q4W39SnrcPTvSyxJR+Ym3ZZqAzEHI0I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eE1lP7bmN5UsfOmE0Ad+bYvZxZ4EemRFNkgbMloyp3gF4Cbfc46qDL9YiFsOL94b
	 rX4nla+OHBcIl5wE0+8pHtZyw0ars8s+8saH1MbWwkfe4xMG5QRExjuW//9jO+MFu
	 sfGckEf8t1fjAY4ZGv93b8fd+liWlz7LPvC4IMsT0lFfDv45pSZLzEGo3w1p2aHdO
	 XoqLWbnXhTxAmP754Uv4704SEVZZ3714MCBJdshbIEmsEzVn7cKETj/sP0oeizQXo
	 emzsgthUoNC0EKr1lyQ5f/7AEZI0KrWNhDhlf5ozyQXwKn4jgdyME0vcHpW43G5Sk
	 CM30wqJVOof5XNndyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1sPzxL01kq-00KZCb; Sun, 01
 Sep 2024 20:16:55 +0200
Message-ID: <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
Date: Sun, 1 Sep 2024 20:16:54 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240901091214.15199-1-gye976@gmail.com>
 <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CR5+TcXozIdoUiOk9FKxRT5nByzFR2Ijwq09PrLtHazWMVdrO+W
 VldNfC5RVP/PCZE7WVKahtEf0YUTKSZreMvdYPF+57h11WLJd7sm0SMHKBFp3CtVovmfYHB
 o0iGx1wvlE4dG4av3uoii/qxzM3CVYGa4fFIutousyHi5McZV6wh9VsbttXTBGztXNTK6yw
 8/AbyPQRdTVDJja8NJ/GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rP7RDYk1/mY=;B+bCIeagcvmncISAUZu+SNOrlG/
 4J/i/XewD1CRaNRX/yoQnRzoY8byEBSMhQHvm5IOvi5aZHVCPDbSXiNVY3WOvLaXW8AqdGWp/
 7Vr/JcShZCwyxqOm9Kb8n68YLBy9PdxW6kTjDGZxnk5dFJ+yGtZVCt8+Q48HGmqU8CFTDye5f
 nQS5BXAdWPjqJdDtD07cyzvBZy6UjLhOKOPbB8KDhWgkcdrQGL7THer83nYx8eXPOaTZCMZW3
 qhdr1kfpcfyTbmxV94o9gLh22Q/VasXaYS3wFRsMtYYuA9tCNzenZRgxRGV6jmHtXY0l7tDb2
 3ZeUtapgkknocPXNFpOfHPXvuFDifTSfg0iVkl4o/YSkC/CBL/71DcBXyexd9MHqxgTLcGr6q
 BuPgzDj2BDiv8zgwsUDYFsLTbFhJltknFvhwLxcSyvI3m9bFPVFjg30AkmX8qyCDHQUN9fUFI
 LjzgzJGU3gLNdJVDRZ2PARMv26tGa7yD9c4hBWRgSy0/E7LnTvYAh2z1HCgNwTCQG55MVxg9b
 0u065aS4Uhh2gv7TnAZjiQLeqact/fucMLz2mE7X6cLedbng7oyzOCuVZsHtEa5QnE0CzfxNt
 e0hUIiUxDvG2XFTVYgz573Z2sCOxMb8c1GZuM/ceyrDfx7Vu7rB1bUcDODFXbPlqubhHemjCm
 lk2NzzS3Qe6/pRYsSHBswfp89YAG1xFvYT5L6hew2lv5CPBOxuQSQ+RhpAjX9xHY9yBt4oN8m
 ui6JNO89UWaeueZ0+wSfnEwnmwOHD/MoJzGPeVMr5Mye1Ar5nlqpGtgn3uw1VpPxR/U46VeJh
 evOpwFab6JdN4qGxgRlrc4Tw==

> Hello, I apologize for the insufficient explanation.

How will the commit message be improved further?

Regards,
Markus

