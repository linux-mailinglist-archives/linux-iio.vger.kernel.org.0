Return-Path: <linux-iio+bounces-13596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334F9F6044
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 09:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B9A16A86A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF268189F37;
	Wed, 18 Dec 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlAnbncW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F1176FB4;
	Wed, 18 Dec 2024 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511113; cv=none; b=SIy5kWjXVZhvdQ9RQfPba1U3VzbV1iiIyT9hAueykFBOuH3oBbHf6IShSQbpR2gQZlfp3Uxqk6jVBmzGzuOiS0tMQkumASp4MsEHBBheU6lvMtDNmyAH1/EgrtrXAn/G192JtfASH/FIIBk6rvS4Fp8l2SczXi35GhZFvvsY3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511113; c=relaxed/simple;
	bh=RaUWyV/m8b639sivC00QFLGLRquDE8/hw4qzBs5W9hY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=H2dlbMNLRbSDmfnglwZS9qTJcy6zD5bVyIoIx4e2ga/u6jTUOxBdhMy5SiIY9gFdnZn3qNnlJ1a9dER6ImK8tLc++6MtPqPSzBkEwidksAaGyhhys1lPNQCc6Neeu/fdZmMuPk9vawzgi3btSEoXAIEDhLU3y04eHiDYiwDWEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlAnbncW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3004028c714so61179081fa.2;
        Wed, 18 Dec 2024 00:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734511110; x=1735115910; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfBCq0/QSTzaOXzgrjJqq0o7Gj63KOGYM1ElaLTHPQw=;
        b=TlAnbncWRuM6EWqWQXy81VbDjan+dH9pM+CIORYae6KBBSTYOkuOcZVk6vmRLESrm4
         lrOIvkmrJQoyQGHEVX7GA3Fw674OubUVbdTTLj9vTNSAEcdkUTIpoNlnCMgAdpCRIJQV
         l62AXs4Xas10/bB+rT+oS1QWu3q3CbmuMidhmqjaPJuv2HAclS4ZoQCmA0bEeQxZ8HL3
         94sozlPHjfBsF3GzSLIEYJ+2RnmqhrGaWznB0toOeyQFaRGOu60spCh+D9b7Su6R66Px
         gqIEKADeYXihKFfvRe3UZjMgVXm6JU7bA4vw4sDoPxR0DVGqQsY9AlHGmmBtJHCf1NiS
         wJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511110; x=1735115910;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EfBCq0/QSTzaOXzgrjJqq0o7Gj63KOGYM1ElaLTHPQw=;
        b=Bn3ZWOa81Z80UJUtENIwFIl69v6WDMFGrBxxOouwoWwqP90tQoKuYdhsjB0G6JP+Gw
         nUwyjqMiNT+E5tqBHlOjNOgR9AHr88jGYm5lHZEQw95IFIAiKdLUJ5XMr9GALpnGAvgm
         lnKaMMBsF+V3E04iyIpGaEifB4EbT6eEtlH1BUDny3539YsPlUjDSQKnKMI2SdhtkD5U
         ezqBrKk7qASMx0jPYV9zmwSH6X0wJ/2IYooHg+ACBJxgJeGQVNanu3iPi3Br9mjrsZpt
         imLeC9CCAGLbFRZPH5hfQKBk0EZFDJahkTMy+sFNYNq3sOevoPU8qH7UAlPzGslIP3zN
         jEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6msDEdK3dO24mt21Deyn48ggzRgfsF3yau7d8zyvQm4/5IZ9XVrDh1/Fk8dnMd1ylN8zDmwQxtM8=@vger.kernel.org, AJvYcCUeAXI58BPwOjjTTwuTJNenEEF3QDVac6ECrMFkCGye3OjNx79pF2SoFRwrMOX+Hopj0gM5HfbwaJjC2MKG@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYqvhnACsT/+JrY2utaaLJLqJWlvhUM7jnjkq2zEfShRFiBbO
	/7dcjLBGicgdqR3amcCERCUsbNsZTfW4LM796OS73B0eMunrGZ0m
X-Gm-Gg: ASbGnctVWN2p0TCscWfd7OM/SFQLA7OKXxeabFGeG9NM2hHaGSEfh9LuQvjOEKVbmWl
	1LGVNpJ6nCBo3rlqRO62yKsQBTTBVuhwyVIPBsQN2Sz1Ax8DUaStvPu5IHMYElLkb+yUX2usl7L
	rIoRrhBlOfLR2LqT0zj9cbt9QShyxZQi4vENopqJouwyTRUY0U5pv9hFQ6r/cC/Xhqy7T9TQmPb
	va1dlDxJGwbWi3JwbBxaoGLKO72chpb6upRU37sngZdbDpa81aoi8vC36Ej21onS41SgA==
X-Google-Smtp-Source: AGHT+IEIkkx/MZlpN82UY1lRdxGyemjAMAcMDtyXMZI3nKabWUn9l80gZ1iQeYH3ns9kCgrrK3iLVQ==
X-Received: by 2002:a05:651c:198c:b0:302:26ff:d0ca with SMTP id 38308e7fff4ca-3044dabeab7mr6297221fa.3.1734511110133;
        Wed, 18 Dec 2024 00:38:30 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a5973sm14758581fa.107.2024.12.18.00.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:38:28 -0800 (PST)
Message-ID: <3f5ff01b-8c32-423f-b3cc-a95399b69399@gmail.com>
Date: Wed, 18 Dec 2024 10:38:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, en-AU, en-GB, en-BW
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Matti Vaittinen <mazziesaccount@gmail.com>
Subject: iio: dac: ad5624r_spi.c - use of scan_type
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi dee Ho peeps,

I started drafting a driver for a ROHM DAC. I took a quick look at the 
ad5624r_spi.c, and the use of the 'scan_type' -field in the struct 
iio_chan_spec puzzled me.

I think this field is used by the driver to convert the data from user 
to register format while performing the INDIO_DIRECT_MODE raw writes. I 
don't spot any buffer usage. Furthermore, as far as I can say the 'sign' 
and 'storagebits' are unused.

My understanding has been that the scan_type is only intended for 
parsing the buffered values, and usually when the data direction is from 
driver to user.

I suppose I shouldn't copy the ad5624r_spi.c use of scan_type to a new 
driver. I'm somewhat tempted to send a patch which drops the scan_type 
from the ad5624r_spi.c, and adds the 'realbits' and 'shift' to the 
driver's internal struct ad5624r_state. This, however, will change the 
interface to userland so maybe it's best to not do that.

I wonder if I am missing something? (That wouldn't be unheard of XD). If 
not, then at least a documentary patch with a comment "don't do this in 
new drivers" might be Ok, or how do you see this?

Yours,
	-- Matti

