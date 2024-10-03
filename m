Return-Path: <linux-iio+bounces-10074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D541498F541
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590131F220F7
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF81A7AEC;
	Thu,  3 Oct 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAHcTvDy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C040182A0;
	Thu,  3 Oct 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976882; cv=none; b=HVnM1QUuGggSIOcPHe1Ek1b7qYlu6x0F2DoWi4tfn/gZRF7+yw+8kR/GpuPVw5xpv/FUu9EICbjFLOieM7FQT21WvRFxgJ78Zq7cd+CC9N2bsdQyuSqOg1fdiLHW/GTbhE67NgA46Ba3DSC11I+Oz8M8iQz0mdpunf/aqINaAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976882; c=relaxed/simple;
	bh=HdEQgXceb0XBmyaMVpZjRlic0GVyOrEgJ48g0VrutpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NvxVC+ZJunmp2bs/kDh6U69ZryENGXpwJgV7AZsOQ25NgV+nvSeChY3laLymiA+t8mktjSBFsaBxj0DbLwfuD8Y4ibA1kmdNbouSlr0dpcqNUwUUoG8f7i4B6TKTmBOn0MwrDc46/ptLyTWhCxxECTZcH9eFwbqenx457fdCkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAHcTvDy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso11375755e9.2;
        Thu, 03 Oct 2024 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976879; x=1728581679; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cY5iibz6mZQz5n5gjQ67PgTaHlR0x76DBuf5jz5YtI4=;
        b=NAHcTvDyRIICXUFTxDmqFLYHh+NlRrWaKo73UWUlHZL+H442R2nxJeqtUffJuDqfYg
         6mcLVUsxaYByqxy5dwuO3ah3pJ6KJyx95yx7W7dBzzfxqe9TG5uuauDUOrlKp+MXsaZY
         qw/pQzqmxuYqdkE8wJswXDAYx7R5n2ksiPAa1bt2L+UoifVI5KQpmBzlDamtv0GyJ8mq
         5AolgJB01r7HlWn6d63d0emmAwfTFSAV/aRiaBhVqG0nMqlZFqs039SPK3B+Nqb1ceVC
         JMXTzsv1bVfbGcsyJPes04bHMftvwcHhRfqJJrBCqkVh3JWxLrUgBq8RNUWxC2SXB2W1
         27/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976879; x=1728581679;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY5iibz6mZQz5n5gjQ67PgTaHlR0x76DBuf5jz5YtI4=;
        b=eJDTGJv5Mh30BlhRDmmBbSA+PiibWgkzcpZwpDEheFbrBPx7wt+waylgBClQNhr7Z8
         iIOq0naVgm7C66VB6mvIj9lsyIEnP/XZE0VlfsNKC+F9VzRrYTHuKTzSHLQg6ZoghX3z
         gMTcSENt0dHwCvdj2+ZD1aSXC9B7b3SwjyvSuNg6vlfaD1Emca5pWrOrHVVgmoj2NAfS
         KEbrG5WIeyKUrZFhprXswR/PT0jkIPtGOBend1EyT3otpI2TCbcjLZaDEeI0UKd+mPpK
         bXaMmfy0a/RcJLLoVvZ6aTj8bXTw/uDJjdukACEmnxo9u2lT7MbNIAgfiCi9nJU2yB+5
         UMIA==
X-Forwarded-Encrypted: i=1; AJvYcCUe82SYa12p3W3PGUsIYcHfuu5yWW2bdzBmXozuhd3ZKQi2Xt+nhTZTkHhtNRk7cltifwkZ4p39u4q2cw==@vger.kernel.org, AJvYcCVz+nQuAuabsq/wFV0kb9/GtOIQQItYIIDsBan3Tu2Z35Ao3l6EBO5bLT5OkoxI1U8n8QcYa6cvBiGMNa4=@vger.kernel.org, AJvYcCW3d/xfV9th1bCsyZsQxcINRO+7wbCUSIn9rmplSq/KOw540QH9gEaEI3bqs1MYrTsLpMoOPtW5dIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZZn92+OlUz88d5K200oVZaEsl2VJBp7N7sFwCavXjor4PIKV
	qLiYVhLy6fjxJ1ho9OOvnju0zUbDyKHMR1ul1Ue8TDmViBZIb6aPZaESJazL
X-Google-Smtp-Source: AGHT+IF+koBvsXCIg+fn2Z6w9z+JMRoOhrigoCbdzK8x02UC4qm5C0DCEdeY5+niMvTpuEfu74sFEQ==
X-Received: by 2002:a05:600c:4f86:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-42f777b0176mr59251265e9.4.1727976878506;
        Thu, 03 Oct 2024 10:34:38 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f74d9sm1739572f8f.7.2024.10.03.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:37 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH 0/7] iio: fix possible race condition during access of
 available info lists
Date: Thu, 03 Oct 2024 19:34:05 +0200
Message-Id: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3V/mYC/x2MMQqAMBAEvxKu9iCJFupXxOI0qx6IkQREEP9us
 JspZh7KSIpMvXko4dKs8SjiKkPzJscK1lCcvPWNba1n1cgJElgu0b3gDsngeaqDFwc3dS2V+Ex
 Y9P7Hw/i+H46oiZpoAAAA
X-Change-ID: 20240802-iio-read-avail-release-cb3d2a1e1b98
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

Some iio drivers currently share an available info list buffer that
might be changed while iio core prints it to sysfs. This could cause the
buffer shared with iio core to be corrupted. However, note that I was
able to trigger the race condition only by adding a delay between each
sysfs_emit_at calls in the iio_format_list() to force the concurrent
access to the shared available list buffer.

This patch set extends the iio APIs and fixes some affected drivers.

Summary:
- Patch 1: iio core: introduce a iio info release callback to let
  drivers share a copy of their available info list and later free it.

- Patch 2: pac1921: handle the current scale available info via the
  read_avail+read_avail_release_resource APIs instead of using an ad-hoc
  ext_info attribute. The latter was used to avoid the risk of a race in
  the available list.

- Patch 3,4: ad7192, as73211: fix the possible race in the drivers by
  copying/releasing the affected available lists.

- Patch 5: inkern: make consumers copy and release the available info
  lists of their producers, necessary after patch 1.

- Patch 6,7: iio-mux, iio-rescale, dpot-dac, ingenic-battery: adapt
  consumers to inkern API change by freeing the now copied available
  lists of their producers.

Tested:
- pac1921: could not reproduce the race condition with the new APIs,
  even with additional delays among the sysfs_emit_at calls during a
  shunt resistor write. No new issue found after the change.

- iio-mux, iio-rescale, dpot-dac: tested with pac1921 as producer, which
  was adapted to produce a mock raw available info list.
  The tests did not cover the driver features but focused on assessing
  the function call sequence. For example the following traced function
  graph shows a read of the dpot mocked out voltage (with ftrace
  filters: pac1921* iio* dpot* kmemdup_array* kfree*):

 3)               |  iio_read_channel_info_avail [industrialio]() {
 3)               |    dpot_dac_read_avail [dpot_dac]() {
 3)               |      iio_read_avail_channel_raw [industrialio]() {
 3)               |        iio_channel_read_avail [industrialio]() {
 3)               |          pac1921_read_avail [pac1921]() {
 3)   5.208 us    |            kmemdup_array();
 3) + 11.459 us   |          }
 3)   3.167 us    |          kmemdup_array();
 3)               |          pac1921_read_avail_release_res [pac1921]() {
 3)   1.709 us    |            kfree();
 3)   4.458 us    |          }
 3) + 25.750 us   |        }
 3) + 31.792 us   |      }
 3) + 35.000 us   |    }
 3) + 37.083 us   |    iio_format_list [industrialio]();
 3)               |    dpot_dac_read_avail_release_res [dpot_dac]() {
 3)   1.583 us    |      kfree();
 3)   4.250 us    |    }
 3) + 84.292 us   |  }

- ingenic-battery: also tested with mock available info produced by the
  pac1921 driver. Following the traced graph part that should correspond
  to the ingenic_battery_set_scale() flow (which is not traceable with
  the additional ingenic* ftrace filter for some reason):

 2)               |  ingenic_battery_probe [ingenic_battery]() {
                ...
 2)               |    iio_read_max_channel_raw [industrialio]() {
 2)               |      iio_channel_read_avail [industrialio]() {
 2)               |        pac1921_read_avail [pac1921]() {
 2)   4.333 us    |          kmemdup_array();
 2) + 10.834 us   |        }
 2)   3.500 us    |        kmemdup_array();
 2)               |        pac1921_read_avail_release_res [pac1921]() {
 2)   1.791 us    |          kfree();
 2)   4.625 us    |        }
 2) + 26.291 us   |      }
 2)   1.583 us    |      kfree();
 2) + 35.750 us   |    }
 2)               |    iio_read_avail_channel_attribute [industrialio]() {
 2)               |      iio_channel_read_avail [industrialio]() {
 2)               |        pac1921_read_avail [pac1921]() {
 2)   3.250 us    |          kmemdup_array();
 2)   8.209 us    |        }
 2)   3.458 us    |        kmemdup_array();
 2)               |        pac1921_read_avail_release_res [pac1921]() {
 2)   1.542 us    |          kfree();
 2)   4.292 us    |        }
 2) + 21.417 us   |      }
 2) + 26.333 us   |    }
 2)               |    iio_write_channel_attribute [industrialio]() {
 2)   4.375 us    |      pac1921_write_raw [pac1921]();
 2)   9.625 us    |    }
 2)   1.666 us    |    kfree();
 2) * 47810.08 us |  }

Not tested:
- ad7192, as73211

Link: https://lore.kernel.org/linux-iio/20240724-iio-pac1921-v4-0-723698e903a3@gmail.com/

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Matteo Martelli (7):
      iio: core: add read_avail_release_resource callback to fix race
      iio: pac1921: use read_avail+release APIs instead of custom ext_info
      iio: ad7192: copy/release available filter frequencies to fix race
      iio: as73211: copy/release available integration times to fix race
      iio: inkern: copy/release available info from producer
      iio: consumers: release available info buffer copied from producer
      power: supply: ingenic-battery: free scale buffer after use

 drivers/iio/adc/ad7192.c               |  22 +++++-
 drivers/iio/adc/pac1921.c              | 128 ++++++++++++---------------------
 drivers/iio/afe/iio-rescale.c          |   8 +++
 drivers/iio/dac/dpot-dac.c             |   8 +++
 drivers/iio/industrialio-core.c        |  14 +++-
 drivers/iio/inkern.c                   |  64 ++++++++++++-----
 drivers/iio/light/as73211.c            |  23 +++++-
 drivers/iio/multiplexer/iio-mux.c      |   8 +++
 drivers/power/supply/ingenic-battery.c |  16 +++--
 include/linux/iio/consumer.h           |   4 +-
 include/linux/iio/iio.h                |   4 ++
 11 files changed, 185 insertions(+), 114 deletions(-)
---
base-commit: fec496684388685647652ab4213454fbabdab099
change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


