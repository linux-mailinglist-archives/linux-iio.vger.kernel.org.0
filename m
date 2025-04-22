Return-Path: <linux-iio+bounces-18535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DCA97A18
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69C93B3FD0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B92BD59F;
	Tue, 22 Apr 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mGqrO/P6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D026D4CE
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359728; cv=none; b=I6rGwzpqkBbWkn5aesckVp9RkM+8jkwARXHu6eJrbKbsTBsRp5iJVMZUioOEaiZbgi4AqQnIK5Ap0qpgeMUgyTxCpeGbzNLLoGUT+Nx59Xh3kzJVNheGuDkhnTbXSvNKUv+XnotLMiWx7mVaRB4gBiV3L6/jD/XD3S6qkI0vzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359728; c=relaxed/simple;
	bh=rhogGrbvpIiVq0G4TvM3WJ17ekGEtgtcDKvgCl8/7Do=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pdaYTBlEkwbiOdtZOAtfP75bAjXd6j8Nz37SRcgNyhk8eQk5Y2IowAElSNQHrPI0nRl9AIutAjQWL2dOT3czA8zunbfLtHXbNv/MAYnbAwM8Am/iqGSwEA5j3+r4vWqsk82u++KA6k+DybEfL1CmJtVQGKmqk0er3aGMGz4Irsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mGqrO/P6; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-727388e8f6cso3392684a34.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359723; x=1745964523; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UK8PbiajcOpYvYW0ar2JlHmkS0MuupsIJbGCtAbGkUM=;
        b=mGqrO/P6zbAkR9kT9VFlePYCou9iwZbZ1iyQeO8y9y4Eelw78qw8RjdmIX0ZAmn4ln
         i0dEBB/toxgjA4gtyyFYaKNK2kiYMmrH9BMpQykbIaEvddhnUHoEKIA8LDVKyg1W8fqj
         NbJewL5/YItyuq2KYk60LZfEjdV0ib7XrpuFJyhTDMNmuW6eZ1bJwPHCJl8Yxl/PCcfy
         THEgZEbogHdoI6vRiUo9aMG7E6sqmp76nmwVt94MukKQ6SPJ3EF4WrtZ8iwEzgcI/YM0
         /B+9zeBfo0ZOOPCloqT5Se+SvE9xz73Q2epOTo0izHjARhHS0wtrrqz7nEGhAxZ+d1rJ
         HbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359723; x=1745964523;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK8PbiajcOpYvYW0ar2JlHmkS0MuupsIJbGCtAbGkUM=;
        b=GWn32DdAW71C9DpI/otPFvMI6rxYNh8fynpvMpRMnzPeIqsMH4BwaxNWDD6ZSi/J+A
         uKkftmJjggtc7hvVV/TPUcagzjqfl/a2RDrOK7rzVtdLzrR50c224reQxBgtk9BSEqJC
         IKb+s7z/XmI93UbRF/5chv+2kndvzqIwSO+6LJKck/I0sAOgcUlh6zSsx/ZKAj5GNLKJ
         njksm0gfYVkH2B0fY2M4iHn7gbeek+z6oVzYw18wUmNXbCxKZMy15I6G4JWz4X3tCWyK
         eTJEg15H8CV1bOX/0Y+4MH8d+5lU1US/PnvlMJ4C9zhsTeOcQaXb73jGczYw+52rb5Cx
         0V9Q==
X-Gm-Message-State: AOJu0YzuZ4eH1gSB7u4XZ26OFlk7iU+pMTaiCl8aoix0Vv9xt4g15shl
	rsvz6kXOzrIpGlQnlwcweTmwbvUuuAzvtx3jTChxW+Og7LhsHqxQTM2jF96BYVY=
X-Gm-Gg: ASbGnctiSpeafcC/gJQIKPMiVouaHHSR7ekWF4uQY+xMh9nKNFbq+AcAvNA8iYfPlB3
	tgLQqhddlT59MDqeismZzsBnJTqTvCQwv9qRRvzo9WmT1/XYycKL7GcNbGSn7ErEXxsS5yCgWKH
	RC07KpYQWt9lfn4V4Ip+4q9fhGi+crpyrwkrkP3cbRYdH5WskOduk1HuACUUpjMxLe9RYV2wZ9i
	c2P0Idi3KkM6oZ41EnAG1RP9FgYFLjQvmdl6m21HFi183ywPh+LVqBEi8dnk9X12HupLYJ9q6jR
	RmqAi5rAlu2A70ujUi5PwJD88s5eQ8DYQ25OxT/4NiKmFc8=
X-Google-Smtp-Source: AGHT+IF49b6dl42zzEhPE+viwqBoREWaATjZV9raTcKU0/tbe0AdVa7W21BaShLy+/F/vIG+5DzRQw==
X-Received: by 2002:a05:6830:6992:b0:727:3664:ca30 with SMTP id 46e09a7af769-7300622d4e5mr10916324a34.16.1745359723490;
        Tue, 22 Apr 2025 15:08:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Date: Tue, 22 Apr 2025 17:07:45 -0500
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADETCGgC/53NQQ6CMBCF4auQrq0pRYG48h6GNKWdyiRIzbRUC
 eHuFo7g8nuL968sACEEditWRpAwoJ8y5KlgZtDTEzjabCaFvIpL2XJEz3GK5O1sYJeyYEZNoPr
 ZOSD1wTioGLh0bdNUrrHa1izfvQkcfo/Uo8seMERPy1FO5b7+EUklFxxAmFrqqtLC3Xu9jNgTn
 I1/sW7bth/SVdcs4wAAAA==
X-Change-ID: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=rhogGrbvpIiVq0G4TvM3WJ17ekGEtgtcDKvgCl8/7Do=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBM2U32J0Jom2quf2SqcjIS6bRq0JB/NvJ21a
 sjueXDvijeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTNgAKCRDCzCAB/wGP
 wGnrB/wNsBqRI2GZ9sOzr0F4p8FofM7AG5l+PtGc3eJ1OqI670Ap3vo+QuNdo5NP1N4cp2XTEnf
 vrSMI+T5OOcpEDI5EvUIIJeqzkDURnbIaYATNqIua5DDdR7RPCVxScPimhS0oHfl7XgXjYgIS3B
 YOiz9DEJvfXOaZd8msPCY+850eajcBbewH9veDYi5F8r26N15b7jWQuNkOpwC1okEKfcUbuzwSi
 VcL9rHzUWeDvJIG/OsRF1zZmcImQ3jz6G9DvUTQvFRlGRHlcCvz7jrK8405szLLrqE6q4QF1Oct
 x0SyyvAisTtFTbZrbQdMfOpf0cKscRMTzyziDyFzR4kVIsC+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Creating a buffer of the proper size and correct alignment for use with
iio_push_to_buffers_with_ts() is commonly used and not easy to get
right (as seen by a number of recent fixes on the mailing list).

In general, we prefer to use this pattern for creating such buffers:

struct {
    u16 data[2];
    aligned_s64 timestamp;
} buffer;

However, there are many cases where a driver may have a large number of
channels that can be optionally enabled or disabled in a scan or the
driver might support a range of chips that have different numbers of
channels or different storage sizes for the data. In these cases, the
timestamp may not always be at the same place relative to the data. To
handle these, we allocate a buffer large enough for the largest possible
case and don't care exactly where the timestamp ends up in the buffer.

For these cases, we propose to introduce new macros to make it easier
it easier for both the authors to get it right and for readers of the
code to not have to do all of the math to verify that it is correct.

I have just included a few examples of drivers that can make use of this
new macro, but there are dozens more.

---
Changes in v2:
- Add 2nd macro for case where we need DMA alignment.
- Add new patch for ad4695 to convert buffer from u8 to u16 before
  making use of the new macro.
- Drop the bmp280 patch since it was determined to have a better
  alternative not using these macros.
- Add a few more examples to show the non-DMA case, both in a struct and
  stack allocated.
- Link to v1: https://lore.kernel.org/r/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com

---
David Lechner (6):
      iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
      iio: adc: ad4695: use u16 for buffer elements
      iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
      iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: at91-sama5d2: use IIO_DECLARE_BUFFER_WITH_TS

 drivers/iio/accel/sca3300.c        | 18 ++----------------
 drivers/iio/adc/ad4695.c           |  8 ++------
 drivers/iio/adc/ad7380.c           |  4 ++--
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 include/linux/iio/iio.h            | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 35 deletions(-)
---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


