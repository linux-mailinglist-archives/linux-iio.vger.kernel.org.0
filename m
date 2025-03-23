Return-Path: <linux-iio+bounces-17209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417CA6CD94
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 01:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFDE1892566
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 00:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2801FBE9F;
	Sun, 23 Mar 2025 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB///dna"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA81FBCBC
	for <linux-iio@vger.kernel.org>; Sun, 23 Mar 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742691191; cv=none; b=FObVfLkvWBnKU7AZnbQQ98TggJkatHOju/7tEzXYZvQLTiylCztNOORSUbu75K31L5spWMMiX4dXD1ED/u+w9GWSaujz+FdRgIwZllH+Aqo3oWTph4LVY+AwgPb5rtT/B02Jldg1UR7igzUYJ0oad51OPa8mLYdwOjWHrrTyHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742691191; c=relaxed/simple;
	bh=d42bapdoRPO/KESBwtPoZjx7TyncQrHQCYMP3J03mRk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ItHpf8OqgSpsoZfGFFNBTgzX91tK2Oatz07ZK+pyuZbA4mpslj1fglTme933tvmLcwcyIG3e2gLbbQveB3qeu3Pp4eS8cvIux1d4eTq+qMdDLNrnzRimOeualBcXLQW0xrbW+kdQtimmtZD+5CwRFDcDZIvT26rthKS5AQm9Ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB///dna; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30185d00446so4055125a91.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742691188; x=1743295988; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d42bapdoRPO/KESBwtPoZjx7TyncQrHQCYMP3J03mRk=;
        b=WB///dna5CJ4YBz8kbbfulaZT+oJdhFURD+trrwKHKEoKWcgYKyX/pg2DCJb72JvA4
         emhqnXYOHhbiRthErttpdF586ZE29M84fLsQ+K2lvbDIBevLRUq8dYLRvV/zBD3qlJHU
         18fQTuSIvho7aTUpH1jlTet6a5uw7zJgERN0g9alG1mRUC6KSMn5Lz0aSvFZTJlh7/er
         /9D8p1iOx7FtHQqEHS7psAne1f+Z60h2j5bhlLc2RBpraPAUnyEu88Mqvemvx/B7FW9T
         17mMGeU9ykAYsvV/VD6CN1hYWbnXSDUlueS/vwuRWQLyQPhbUGJMdDFhMOwDAbV6resi
         tZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742691188; x=1743295988;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d42bapdoRPO/KESBwtPoZjx7TyncQrHQCYMP3J03mRk=;
        b=h/OY0WqiFJvtZKvSasJXejTuW5AVOhRx3UgFcl5iZpTMrVrwIxnQNp0k4K+jUrGzw2
         sfkQNxXnuH5Gd1FLwS8ztIm2kRV+b3qhgtDNrnMyJsIlkQ7+/PNVdblzEUSy0mY7B9p/
         VyXDqjaiXly9oTdfvcHjD4Gf/d/8i1lVb9madfGsXVO3solvVgV77YCpakH40QLOVBMy
         P1j367z4o3xEe7uDxfXTuzxL916ljONt+W7uXw94hvghTVbMjYBBPrznoUC0DPu64O3V
         FterYUoBszvfFcS/63XNIFexyafas4rE3NodxQrHW4hlN+jYOB89O8tMnXmsi9yUcvdL
         4GYg==
X-Gm-Message-State: AOJu0YzqRrXY7xLj6dt5ofnO/IUh3HN83iKiKmfMRZi5cvb+eNy8hjpD
	R0aBCuTG2TaCLim6IMnk9tcbHRKcLLTiLNAcgCs9WflT0eWiv5DaK6onGpyd5Iq5oavYVmbHRcq
	a+0vrBiBtJ8TYQwUjKrMpvimoyA6CuyUyDdA=
X-Gm-Gg: ASbGncv/CGhx5KP/H98zjc9Q3LF9zu1dZxNOs0lSh1GqDuPdjmRKseE5JHMA7Rw/fQd
	D03e2fVsXgJYUbnz7kI4DKfzdmpddsD8uL0EcczX1fPaKD2CCu0Fyqy6n9TmpcDa8aZsGib+h3v
	ftNy07i4TXIk8uPdiEEbuIJ/vnPQ==
X-Google-Smtp-Source: AGHT+IFEREWJsxet4nBdr3QGD8/st6t4S1Ynq7COIdTS1uFOssXS6Fxfp42C1y3o+El1QlP9heEb71OyC0kftUZ3Iqo=
X-Received: by 2002:a17:90b:4b8d:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-3030f3936e1mr13718965a91.14.1742691188352; Sat, 22 Mar 2025
 17:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?QW5kcsOpIEx1aXogUi5DIGRhIE7Ds2JyZWdh?= <andreluizrodriguescastro@gmail.com>
Date: Sat, 22 Mar 2025 21:52:57 -0300
X-Gm-Features: AQ5f1JrVHlGw-0bTP4h8T4NqdhClN5Y67H0uI8l83MvhJNuyj51xBZVlaF0j4Yc
Message-ID: <CACDprpJx-eVFCX4req7fZLCGQ7=dbTYsji_j7k+WjttUTXb2mA@mail.gmail.com>
Subject: iio: GSoC 2025: Analog Devices, Inc.'s ADE9113 proposal - Community
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I am Andr=C3=A9 Luiz, a third-year student at UFPB (Federal University of
Para=C3=ADba, Brazil). I am pursuing my Bachelor's in Computer Science and
wish to participate in GSoC 2025 as part of The Linux Foundation under
the IIO workgroup.

Following the proposed project from the IIO GSoC page, I would like to
work for the driver development for ADE9113. I am very interested in
the device since it's a challenging proposal and it offers a wide
array of learning opportunities. I have prepared a draft proposal and
would like to request a early feedback

I'm very thrilled to fight for this unique opportunity to sharpen my
academic focus and professional future in the IIO workspace.

I'm not familiarized with IRC and IRC nicknames as of yet, so give me
your feedback.

Best regards,
Andr=C3=A9 Luiz

