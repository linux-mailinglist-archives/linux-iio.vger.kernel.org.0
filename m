Return-Path: <linux-iio+bounces-17521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44064A784D7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C10F7A3F99
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F74219315;
	Tue,  1 Apr 2025 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="itJMp6hL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7821EF396
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743547837; cv=none; b=bi1zGQH9QS8QbBZY+YT0JcMrgZI30bKGDwiNln7ChXaYAatw5HavCqaF4dOf9KBlGGch8g48a2v3QhWgDLIOAVFteCyVXFk9F0x5dIlHmOLfvcAIsB1rl4oJDY0Bm+9bOYOmQQ8XtIdM9ICY+UPNj5paSZ5NFAidzbG0dpsbS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743547837; c=relaxed/simple;
	bh=YAlLqkiUmn3HLW9UEES3iRfYVjnsBQso51HpCIG25JQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Miffwp9HXRnlXTmCRb6inNLW1lq5a8KC4sUqgZpxf/gWduZp0OBQVlhLNrLSD/OK0WLYvIxUZNGpt/K4no3Nw5q/xRZ/a111lPCZihtkbVTdhfVsCBD0rgqVRDYgSOTbnASnGgjXJZjr3EJQ9RnnEI76dYIyiRYb0+a4Wz8HXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=itJMp6hL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c72cb91e9cso175426fac.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743547834; x=1744152634; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KzpsO/kBfwd4inh4brwX0T0qUV9oBaxwEbylk8edno=;
        b=itJMp6hL7yLifBXJCZeS6T00kh9130OjC/qiv2cftxOXRjFR4Pa96bWm3A60nwkedz
         R3JinWmRhS8dOn50t7gLIm5d8PryAy58sxDP+tYb6/5qmzSu5ba8fOBOZHt8zKW0TmTC
         bMBe9GHYMrng1ZgkwCZD9nkQRAV4QZfBpDSswHmuk8X8lvVFRaOLSnwVhilVPa4KoDyH
         IhQSonikSjbpNWQibSt0SNiOvqjpStOKpPPrDGTpGd1ZWc9YZVUQ4BLl6hRtJU+s20G9
         UDwTHmrKHsG01zxRnC7hNQhQVRABaxIZVSk8s0tQqebbMRvH805TeEZWRl2cNTUbpU0T
         DEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743547834; x=1744152634;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KzpsO/kBfwd4inh4brwX0T0qUV9oBaxwEbylk8edno=;
        b=JBK706oFq1dUENck7/PaW5HW9dbkGXY07v6EJ+Fa+EGLTxJcg0ElZNFUWwhue96gll
         tnYJsa8Ts0rMQiYtjFBfrD6krVjf2QQGXYUJLyAfpwEnuo1QyFG255TQWhDdwfviQEh2
         sA+yeTNMuiDtbx1mzXQ43fK0tcfP0CnP5xvFHsVpb5X+hJ6Pg1mR4q5opFnakoY4saAI
         chIdCLzZoGz55BUuG96lesjfPBBBLNioDryni6n+DnzAUX5PzUZhu8bUgWu4/qz/oG7S
         og84kTe36NDlj7/M6Q4LpLrTjHckpeuIaFiaRNokKs4ZyXFB3Jzf7IjwZCmEF55/U+hV
         eaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0nkFtczNU/S6wxjPg802CEizIALxvU+JgNOEetcZgf6PFHEAKXarVJHjNrsT93q0GONL1kpOE6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEWmuD62b3HXj7ceEcNeRaV/zqeO29YiOT10JKZ6OXsrOdoxa
	HEuUN7GJUsFZtWy//NLqCr+16O9UHGn19FHf4B0GtkPIL44rmmiS5uuYgBQfb5k=
X-Gm-Gg: ASbGncsKfdfPhuRsuZCSj7JmhDOsfq0uwv6gLSCKKLpMIq+jkoy6qDExUTpEjmPGv1J
	9azW+BJSm/YmGlKleSFmhAn8Y1iRg4gZNdVJ419Aa4+ML/XNCYgILiS57+LenEo0syNZXMVBCwd
	R+WfUaN87QG6DHUPCsOyHBp7UJGg3G6hOOw4WPBko+KF6f03xBVCX0a5rnSrH2zoPBkZHqF6omL
	LRt7JXPlKDsWwHON0q2umqi/bAd+Cbljffkj2a1/bRHB68b/kvaDF59om0zUMdfmVyaVYNLedz+
	TJZWceHdniXcEu5C7fDQV+xph3ShsZyW/rTTBZHRESJ5ysT+Ik/5DZguisFRT8vcXQEQsdqvgYc
	2
X-Google-Smtp-Source: AGHT+IFSez3et7WKBsDlKmMYtgl2hfH5thKM/Tt23C6oNV6Ycv2F2CQ+eNAr/KccskPj3MVGvqv3Ig==
X-Received: by 2002:a05:6870:ff93:b0:2b8:65f7:8268 with SMTP id 586e51a60fabf-2cc550a11e4mr1066371fac.11.1743547833793;
        Tue, 01 Apr 2025 15:50:33 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a860267sm2541894fac.36.2025.04.01.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 15:50:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ad7380: add ad7389-4 support
Date: Tue, 01 Apr 2025 17:50:07 -0500
Message-Id: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ9t7GcC/yWMOwqAMBAFryJbu5CfxngVsRB3o9uoJCCCeHeDV
 vOmeHND5iScoa9uSHxKln0rousK5nXaFkah4mCUaZRTGkV2nMjbThXQPwM61LElS55m7wKU95E
 4yvWVh/F5Xjnv09FpAAAA
X-Change-ID: 20250401-iio-ad7380-add-ad7389-4-1f6d3d7dc749
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YAlLqkiUmn3HLW9UEES3iRfYVjnsBQso51HpCIG25JQ=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn7G2ji5jZGeBcfDlKiaW9oiPp8fE0x2NefCXng
 IV4mEI86MiJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ+xtoxUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANDlBAAjJs9Hsb2pr80RJr0dynacRF3AA3EXEZOBA/50Jq
 X0W3pne1SXihcZdmS+0RlA98QHthDG7+noKnN8ME/V65oCJdZOSM5pWVaden3dQxCJp1bnvthbx
 A1857Szgkm93pR9OpsTg/oMs7OUSLIulOzR2pOfQq2V7trNoCjw3++Rq6o5KD+7vyi/m5RJD+nU
 lilNSLAui4aYoqCJShuK2uLl1gGIHHWtbAs+kuVokPKZSO0qmQ9znVgo0NkTrqW72vhC9aY5MQV
 yEY4piz+F/PSy9ZCbD30jZMWuPEU52E723U5gQRvlytQmWbOoSWp8ThAu1a4efGzdFJ0tNawCCR
 5DSZpFTduiQ27S1UCgjNrWYHyYAcSB2MjUuVkU/ejPoCq/vfoKhzmIUyvuLe2KWW/XXjYy28v6O
 Z4siF4TMFVJDU0fat7yMIsk4kHJngkHXGute/By+eB8ySxcTmftT6b7RoEd9lJH5X0XbY2phWid
 x3uRGz2HWVeUneZQ9JcdvnYfAlcvNiAZhGnCls42wuC7qrtk6S2wfnHDKEvVr8tvi8ih98CWjGb
 DtqMx3//ZBITuW7pJjctLVcTxNps63y/BYzN/Lc+Mh4e1RDwvQiDScOFjVRL3uDvcrB/ijZ/MeV
 H8KxbdobeYPMY4SznVb5H3U7iIrSLiRPY6o9ECH/sHRY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While developing this driver, we glossed over AD7389-4 since we didn't
have hardware to test it. However, it should be trivial enough to add
support without testing. It is basically the same as AD7380-4 but
instead of no internal reference, it has no external reference. And we
already have support for chips with internal reference only (ADAQ).

We have the typical DT bindings/driver/documentation patches for it plus
a few patches to shuffle around the existing code for supporting chips
with internal-reference-only to make it generic enough to support this
chip as well.

---
David Lechner (5):
      dt-bindings: iio: adc: ad7380: add AD7389-4
      iio: adc: ad7380: rename internal_ref_only
      iio: adc: ad7380: move internal reference voltage to chip_info
      iio: adc: ad7380: add ad7389-4
      Documentation: iio: ad7380: add AD7389-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 11 +++++
 Documentation/iio/ad7380.rst                       |  7 +++
 drivers/iio/adc/ad7380.c                           | 50 +++++++++++++++++++---
 3 files changed, 61 insertions(+), 7 deletions(-)
---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250401-iio-ad7380-add-ad7389-4-1f6d3d7dc749

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


