Return-Path: <linux-iio+bounces-10706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33829A3B1C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5421A28417C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CC201240;
	Fri, 18 Oct 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIlnjr9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EA201102;
	Fri, 18 Oct 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246619; cv=none; b=jnOPcLzxw2SCWeqSKUyJc83JoigBUaDUJ8uke3R3ovC2z/NuC587wA3jfuwOeb5j6IYgBq4xTNXa1jbGbaKMsKj84e3obLnhjz1OJk2AhvRBtmG92hHZ8HLrT6h3YvJje1IHSe+8qYofPjpSFlsp+I0SETWOalOYW6o0O0QqwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246619; c=relaxed/simple;
	bh=+C6O8bl4Wumi7Bso/HhpToTetTJ74t0+tksPzYy4D80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nJ1PUB4CGNrxxinZMsS2+UeG66xk15DIcQcXIIzmIH+r4o5E+H/aH2nQD5TqdcUbUqffHfTE/j/U+hx5yi3vTsDBc4R9rgmywOb+ibH/l05bvmOvB3Iyaoq0w9QFLW9kTsLLCZScwcXPr4Gm3F4PTbYQV+RGRrXt5TOJl6PWVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIlnjr9h; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so1401982f8f.3;
        Fri, 18 Oct 2024 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246616; x=1729851416; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGYyqvKLXNV3yQm6wNAxTILfVW50eFL+iw4yPkNAvaM=;
        b=HIlnjr9himRLwQF6eEKHZqXoCto+wIHJQNK5OpbusKDiGPl4rCUxOjW5IbaMURvmJi
         b0TXoOrkQAnD9cG6vTAcnAIr3vK39+xJ5crnA/qvVF5fMkn/obeB9ll3HpVjETYyvIXh
         +gg9EtmTjWoDjbyqkD/A+e88UZyOZ+R67jZJOS/hJ3sl+6+4YDUQ+n5uREsCRLc2XBHj
         ZtdyqyD8UPlgdD4UumCPQZ91exAyYQ2KeMEW+9dWoCQ8BPGJlS8wuqGZ7vW31AU6otGV
         5wzQIVqpfPu6w1p1oB6HtvV3AkB2JShkgVm9sGL0r1YaVc6wO49kzsQgbpd0KcfGbUtm
         Gc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246616; x=1729851416;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGYyqvKLXNV3yQm6wNAxTILfVW50eFL+iw4yPkNAvaM=;
        b=CmiqfC1D0ytlIeYjTpZoL2qAZ0IrfhWxyyU7uk2SD2FNjmEANsigas1QO2tkecZ4wa
         v5GlYGN7OE8zS42hb6OGoIdMKcs2XYyviS9ZLjkV6Pes9gAm6gaI9FsxI3BfgrDt60DQ
         fg72jpqiqpZIBIhpoa/vQ/yuphKfoIkrhBUdow7PxYsTwqLYLjtsP7TQruvqfZzUy38F
         sASgTEU5a2L+sXtHNPPKiySLRoVu9SxTwb3gAPJnbJq2yT0wnbJlF71Qan+7iwmqpLwp
         ooBcnly78i6BsHNmFEjZj3yIWI1t5+KCslUvlM6QephYixIKIP6R8J3gTysywXslKdtF
         o1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUJk5SkJ06Vk8qPzKexnbckJrsOSdDIDFpIoIF6UxHq5MslkzAD9WSAWXdI8MAKoju8gKt2tihNf1JloQ==@vger.kernel.org, AJvYcCUPszkQU4qn8vSTMvateb74t8RDrXAuUYF1x47aZyOo5gZWM/oK+c7IDHVt96bUOrsculBTPXjb3Aw=@vger.kernel.org, AJvYcCUqbtVKQVTvbbgsqdESIqcgRWbBtmElMTo0/glGoOPjVxHSoNvKylL/XYYTU1RTWjjlj9MK37a+7i3BBIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRvRg0s3TvO7MRa5X4S6+kPxyYUr3RGpKvT4Ru4fBN9Qxw6rE
	ey81e7Tg5ecISvS1REZ3yQ6cKtbaAtgfUD2cg6CSDBKw2MnH8BhB
X-Google-Smtp-Source: AGHT+IGdcyh6Gf7+XdA0F5Fka3lGLAqY8PjB7JzYKEhk1BAYCdN6tGDecX3y1r/LOyydpUzFiWDQng==
X-Received: by 2002:a05:6000:18d:b0:37d:3e8b:846f with SMTP id ffacd0b85a97d-37ea2198341mr1380652f8f.24.1729246615672;
        Fri, 18 Oct 2024 03:16:55 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0693ebsm1529146f8f.42.2024.10.18.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:16:55 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v4 0/5] iio: fix possible race condition during access of
 available info lists
Date: Fri, 18 Oct 2024 12:16:39 +0200
Message-Id: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIc1EmcC/3XPwQ6CMAwG4FcxOzvTdSDgyfcwHsZWsImK2cyiI
 by7hRMx4da/Tb+mo0oUmZI67UYVKXPi4Smh2O+Uv7lnT5qDZIWABdSAmnnQkVzQLju+S3knl0j
 71gZ0hkzb1EqWX5E6/izw5Sr5xuk9xO9yJ5u5u5AGwG6R2WjQvgLvq9B4JDj3D5kf/PBQM5lxz
 VSbDAqDRQmAoayPDf0zdsWYcpOxwjhvCeoOS3l3zUzT9AO6vYtnSgEAAA==
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

- Patch 2:
    - inkern: make consumers copy and release the available info lists
      of their producers, necessary after patch 1.
    - iio-mux, iio-rescale, dpot-dac, ingenic-battery: adapt consumers
      to inkern API change by freeing the now copied available lists of
      their producers.

- Patch 3: pac1921: handle the current scale available info via the
  read_avail+read_avail_release_resource APIs instead of using an ad-hoc
  ext_info attribute. The latter was used to avoid the risk of a race in
  the available list.

- Patch 4,5: ad7192, as73211: fix the possible race in the drivers by
  copying/releasing the affected available lists.

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
Changes in v4:
- Patch 2: inkern, ingenic-battery: use cleanup free instead of the
  "goto out" pattern
- Link to v3: https://lore.kernel.org/r/20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com

Changes in v3:
- Rebased on top of iio-togreg
- Squash and reorder commits to allow bisection without memleaks
- Edit summary in cover letter to match new patch order
- Patch 2: inkern: add comment to clarify the need of the producer's buffer copy
- Patch 5: as73211: update comment on mutex declaration
- Link to v2: https://lore.kernel.org/r/20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com

Changes in v2:
- Patch 4: as73211: remove one blank line
- Patch 6: consumers: fix typo in commit message
- Patch 7: ingenic-battery: add missing header include
- Link to v1: https://lore.kernel.org/r/20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com

---
Matteo Martelli (5):
      iio: core: add read_avail_release_resource callback to fix race
      iio: consumers: copy/release available info from producer to fix race
      iio: pac1921: use read_avail+release APIs instead of custom ext_info
      iio: ad7192: copy/release available filter frequencies to fix race
      iio: as73211: copy/release available integration times to fix race

 drivers/iio/adc/ad7192.c               |  22 +++++-
 drivers/iio/adc/pac1921.c              | 128 ++++++++++++---------------------
 drivers/iio/afe/iio-rescale.c          |   8 +++
 drivers/iio/dac/dpot-dac.c             |   8 +++
 drivers/iio/industrialio-core.c        |  14 +++-
 drivers/iio/inkern.c                   |  34 +++++++--
 drivers/iio/light/as73211.c            |  25 +++++--
 drivers/iio/multiplexer/iio-mux.c      |   8 +++
 drivers/power/supply/ingenic-battery.c |   4 +-
 include/linux/iio/consumer.h           |   4 +-
 include/linux/iio/iio.h                |   4 ++
 11 files changed, 158 insertions(+), 101 deletions(-)
---
base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


