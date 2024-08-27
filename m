Return-Path: <linux-iio+bounces-8821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F459603CE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 10:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E211C220AA
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 08:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B320328;
	Tue, 27 Aug 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="C51GT2al"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727A18756A
	for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745671; cv=none; b=K1fl/EhB0aqXfXOjhq8SdnvR0kzLeVxbYqcqViBPfq/b8kBtMLuljBbrM7gNaJ1YfCVa7pII52J6SYrY364HpymQwYFJTo0Arxxwm74+W1oVOk/AqU/fUFCj17LTTz7LhudbqQdNpG8MtsBeouSpJyS20jZrGhTAfkPlj9T75D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745671; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=hj1CgoczbatTMsYI/tPVtHqo98laCpNzJdWFyaOuHBoc/7oy+vYtBtOIiYKch2zEeaioQhG6iTf2ukSmJe8rAzF3KU7o5v0tSpuD1XGG1UYNHHhYsMtxwdm0lIoEV4Ern4O05U2p/NwPig8jvMh/tJvUg8VaEhHJ3mtRpE3qoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=C51GT2al; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 9F5FB26DCF; Tue, 27 Aug 2024 09:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724745138;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=C51GT2alLwXipmSReRGG91gzbkllS46HBrrdA8ldICc9IL7BfG95kJ4qjl/L+Su9d
	 tqnIGsmcJCbM12S+Hl+o/pVfP93QkgzEgZ3N2cXNkLe1LDadnyPby2mqeOr73uR7dm
	 5fv0mi/JkAumkNQMS2S6e8RnXaRJvID2FjSrZezdjrtQhnodW5zE5B9hCO+OucNpxK
	 qeZnL8LAzf5kJZ49wpNgzv5zD9hMvTGAlM2KKjcSWC7Fl4mgmZRLRU+Jr+OsUE9Xkw
	 WiXa9eLqzQF9p7T4GZmcfvn/1jNVLYhCqUN3FoNNxXkQ0M5aHjb5LznU5BVpu0K3T6
	 xknnHLN12AK2Q==
Received: by mail.tradeharmony.pl for <linux-iio@vger.kernel.org>; Tue, 27 Aug 2024 07:50:53 GMT
Message-ID: <20240827084500-0.1.8a.2xi6u.0.d0oo13hdqp@tradeharmony.pl>
Date: Tue, 27 Aug 2024 07:50:53 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <linux-iio@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun

