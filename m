Return-Path: <linux-iio+bounces-2062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E294843A08
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A68C286B01
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7283CD0;
	Wed, 31 Jan 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYf42npV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D83CC6;
	Wed, 31 Jan 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691133; cv=none; b=PDua9DOjNqLk3Rf5BaNgjmb51sPk1Tqp+vATq6GSEdLBsWwJgMRCA53ujajOrFICUrG4hVwdarb0XecIpaJQk+CygxsFok7k2MBrWGj7lvM4HD3f+s898hKA2/iJ5hocX3xBrqs0m/9eK7JXwjPEqCeCJmz3aaOtswCpZTNX3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691133; c=relaxed/simple;
	bh=FTDfH4I2xOVSlwOEyIqiKd8K58r1M7EV8OEkwFEEbxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrrUYdILTfLfoSnt80e110Niz25Y2l/3QZSDLoqL2q70hRf9bfnNqyJ3Ony+j4L5WIW/c9vysKOiX1FqxxQpOYZUDNFSvABGi26y0ezDNi5Tok7q6QjDrNMKUJMgoqHz4XExwLS0PqFOwtXqulvAoZLZxBTVR5SNzW+ROEF/xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYf42npV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ae7ae9ec5so2022483f8f.0;
        Wed, 31 Jan 2024 00:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706691130; x=1707295930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTDfH4I2xOVSlwOEyIqiKd8K58r1M7EV8OEkwFEEbxw=;
        b=FYf42npVdUOjEBIVzUzjoOeKamijJBkeejPBh1Pf5fOQiNMF3mxhK8GWDyLcbiA6iI
         6/iGifquHw3T9KdonxjxDOOhTl5tYkzSNCQWM7DnjatwF54dnngLYqd1fEYwMUUQZU3t
         3fQdatlU2BPPqO/V8BRFXsI377TgMOQN1mwZgWb8EjLL4fzCHYmzEHpjnsjFRMio03Dk
         4mSfKNGPJ/nvdvSKRnRQbDjZSfgUT+yzZPjCFxgE7pw12k4hwdTA4DZioD2Gq+9pF5lF
         cKjC/XB4GIF7mtX+u9i7Yo0IgQSM3hFJ66qT9+urLksrmoW/5BBA8bRlZLSUrZoXaLbx
         79fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691130; x=1707295930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTDfH4I2xOVSlwOEyIqiKd8K58r1M7EV8OEkwFEEbxw=;
        b=L+PPNDZ7lVfvEnoFnkDilT6rY/KiIqijHh8dcq4MGIRUaMgD88CHOPt6OpSD55PZLY
         g8PSdHgXi7kKyG1V0LeXo8QtUavLKTt7kMluCU+RIB9pd0WGAw2zrwjuEON46KHCOjrY
         BzDrdEEhFu3wbpsgLDQz980Uph35GBaUEle1IBGYIZw7bK3t4iAXqfjtNSmHTxh1kuHQ
         IlSfHhQBL3TBM+W4saDPq++luwwbJiNAJRpmp8En7Ip8pO9Q5xELil4L+YCdTrSSESyD
         OiL0LRNWruMbAFpxhbTV/kOlji4mobyNgeSApLR6kDBO80cIQjziCh6jqb+1+EyvSD+d
         K3Xg==
X-Gm-Message-State: AOJu0YxZDTkmbdTeR2ihs6I5VF/BXA92O6D9pDXbisILpR38wLBOmUdA
	Q0mFZlmwNfNeWi5gOp9lJndmV+0cq8dw78Ib7a5zhFxzdh725ivy
X-Google-Smtp-Source: AGHT+IH5OPBlHelYF+NeFWrBZQMbR2Tp24V6rvqiRO/p1didxwohFOORT7Pg2Wfpty76vEFaYSwSEw==
X-Received: by 2002:a5d:64e3:0:b0:337:68ab:617e with SMTP id g3-20020a5d64e3000000b0033768ab617emr858950wri.8.1706691129968;
        Wed, 31 Jan 2024 00:52:09 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe112000000b0033ade19da41sm12073617wrz.76.2024.01.31.00.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:52:09 -0800 (PST)
Message-ID: <30f0aa03081bd98a1a989c508a24f23e049862f4.camel@gmail.com>
Subject: Re: [PATCH v7 1/9] of: property: fix typo in io-channels
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Rob Herring <robh+dt@kernel.org>, 
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Cameron <jic23@kernel.org>, Frank
 Rowand <frowand.list@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 09:55:26 +0100
In-Reply-To: <170664806394.2324419.17581898570868149558.robh@kernel.org>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
	 <20240123-iio-backend-v7-1-1bff236b8693@analog.com>
	 <170664806394.2324419.17581898570868149558.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-30 at 14:54 -0600, Rob Herring wrote:
>=20
> On Tue, 23 Jan 2024 16:14:22 +0100, Nuno Sa wrote:
> > The property is io-channels and not io-channel. This was effectively
> > preventing the devlink creation.
> >=20
> > Fixes: 8e12257dead7 ("of: property: Add device link support for iommus,
> > mboxes and io-channels")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/of/property.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Applied, thanks!
>=20

Thanks Rob!

- Nuno S=C3=A1

