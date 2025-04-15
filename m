Return-Path: <linux-iio+bounces-18124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15EEA89319
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 06:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF711171A1A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B29243362;
	Tue, 15 Apr 2025 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmOzZIex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156223BF9E
	for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744692704; cv=none; b=oiJ7djfc2FH8JycNjd3yxXE1tpVS+MzOF7q7A+qClJIvLxuacsDW6vSkOdOs7oCcQ7RLsz3Ke1hFF5fLCUSkWN3U+QFz6nQObLVzy71DPH+bHvxW/Bnq/X0jvoKb4bE/aMUloWCFdTLKQOSXGfEKSxmyOpjh3Hhp+Uzpoh77YNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744692704; c=relaxed/simple;
	bh=2eWPm7PZo92VYpISD9fVg/rhcIkCNNN08gnYzZMWeEI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FPvXy728Tk5FDqjodBr8sODkkoWkSyANf7jF2bnXF+zbnMeLml3ftBiPUdqxUR6TskDk0XxAHKjaFJHgaDtxRVqcLmyQDBWKM4R26gZPbkUJUw8p2GvVt8LYeKNSJdjea3qP2VyV5Y80ZBX9OUeL5akiiOAzXgAzYLbf5IHJCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmOzZIex; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2cc82edcf49so1417989fac.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744692702; x=1745297502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eWPm7PZo92VYpISD9fVg/rhcIkCNNN08gnYzZMWeEI=;
        b=SmOzZIexnSgLgklCeQ6UI01DdQ+AOdf69n/L7T4ewlYp0QCz0ehrHlihx5/R5fCNPr
         bMDmSUvX163jpshoB+ZCNAuQ5+PXta60yMm5ny7LCrCVPYaZa6igPJd8Glrph9gI8zuG
         2LORSNEzZ+7odSlHfPTs8tIPSmKUiu2F9Gz8fcNBmXj8TT1rv7ZAEdxroybYAO+WSOip
         NlHm6VNH+UOxZ3A+spgc2urix4BXfEV++kkrTGyCpm4BHkPjSYsLvR3XxC/zfgU+XhbA
         dX4ad5iybgSPx5US2eqQ+OSE7SB1XiwTUdDsjlFKotolGX43svCQdPeFpr4Ihd5y4byy
         GSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744692702; x=1745297502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eWPm7PZo92VYpISD9fVg/rhcIkCNNN08gnYzZMWeEI=;
        b=csIwkdTJAn1KUu6V95hn684E7jHYsV6+Shpqt4SP38D7LRysSv+0dfYpvQi/v+mbOb
         nEAOCKTb6JTwemUVZ/2ntJKlIIw465GcXrYP3D1vIaMGdlpiYTf5oJMirY9iaOpMN/KG
         w40Rc7/mv5MqRqfE2yMIosgXLHyJXePfLyceVLHn9TfA4LeTNx3v9sX+iDflUiBcHOAo
         Ex8Jy2WCUzCfVoi66TC0Cl1wq4HjPXaEuLCcJFhm6b1vrVWQm7xg+8A/+saP1U9Dheq3
         yuMNIZFZZE0YOQFR5DCD/mIaLcO1tPWYYueILbS9tI+VM6IoikfirAGLovu1Xy0Exogj
         C86Q==
X-Gm-Message-State: AOJu0Yw4Fz+qHpLsa52ZR+bWsEADMVbrckFhFAIhlPSRBkxRLBHNdAbg
	pRfzQhHc4XIXYjeDYh5+U8wtR+a2akRnWQO7kIxPZAQOL01InOjAgWDmsUgqDrWW1N+riF0G0XW
	9Z2gDrAmGMEjHoy9SIfZvTU+30+ECTWTwfkg=
X-Gm-Gg: ASbGncv1G6FyM0IRdBOTac/yG0S7aaiuUerv3m+iSlCJ6KCQRahYOYbPl2jVdiIPS2+
	A4GFvHrbKbEtNsnGv4qW7BNvj2DPe36aBui4tQQ8yf30TqDbx1Lc+q62/FT+8mS9IIm/0Lip/UO
	4DwYuW+A7Dm644yMc5gNYA7A==
X-Google-Smtp-Source: AGHT+IES4YpbKA7F/yN6h+nKQaaFsYYaC9kDTdW+L4n1N/+Z2JzUIIrdlPDIgoMi5IvWqrgOgAHtn1etIGFVqfj9E9g=
X-Received: by 2002:a05:6870:1788:b0:29e:5e54:76d9 with SMTP id
 586e51a60fabf-2d0d5cce40bmr8197225fac.11.1744692701612; Mon, 14 Apr 2025
 21:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Akshay Bansod <akshaybansod997@gmail.com>
Date: Tue, 15 Apr 2025 10:21:29 +0530
X-Gm-Features: ATxdqUHComzBw08d1uqruThndM4lM87I4Kaa8HimvPJycj_gO_svNKqDX-LB1YM
Message-ID: <CANm0iNgb-pY6CbHSarizGush8qdLFbsdzvuk-XvpnEeNXkHQHw@mail.gmail.com>
Subject: [GSoC][RFC] Request for Feedback on Proposal: IIO Driver for ADE9113
To: linux-iio@vger.kernel.org
Cc: marcelo.schmitt@analog.com, dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

My name is Akshay, and I=E2=80=99ve applied for Google Summer of Code (GSoC=
)
2025 under The Linux Foundation. As part of my proposal, I plan to
develop an Industrial I/O (IIO) driver for the Analog Devices ADE9113.

I've linked the proposal which lays down the approach for developing
the driver. I'm currently seeking for any suggestions or improvement
from the community for the proposed implementation.

Submitted Proposal doc :
https://docs.google.com/document/d/1-cqKEcSmllI2ibl3GTT95A8GCYdnvCPpTA7n3Ks=
1nvo/edit?tab=3Dt.0


Thank you for your time and support!

Akshay Bansod
GitHub : https://github.com/shvass

