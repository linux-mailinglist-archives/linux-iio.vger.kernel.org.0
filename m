Return-Path: <linux-iio+bounces-10613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DD99E506
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CE5284902
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7ED1D6DB6;
	Tue, 15 Oct 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByfY8LvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CE1D5ACC;
	Tue, 15 Oct 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990410; cv=none; b=Ps3obbOR5DT7BrGQGj1n5OJDuGlSdyN4vciocjdepYAw3koUWZo99oreq3UhcE9ITADxW34IJbP8B8hocq6A9L3fJYjl8pEmhIlPJTH+bi0RI+sU9FCLh6ulIxwnchv/2/qbsqk+6XfR8ED1bWLkOwmtM4akHr07lcUwWzsu6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990410; c=relaxed/simple;
	bh=Ko4WSi/iadtDaSjuGJCdlny89dYXdrukD9M36DxsA2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pChBATtdxq2a8N28FvqMyvcJDGL+hfWGCqmrzgZq7n3XZRkBpGhtUVeFYvp0GPs484qgldRkJHyggnTpbeFO8vOL/F+w3Qn85fpOnXdxwK8psX+KNzwy1IZ+NTH9jFPu/62dZdwqmWu8gTbB+MqQJRXnDC2Uv3l5Vz2eojjsYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByfY8LvZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso40739865e9.0;
        Tue, 15 Oct 2024 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990407; x=1729595207; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hTA54qBy+aOesftUvMjeJdoBuyQgW2VWBtnHQwwyFA=;
        b=ByfY8LvZL4ve+vdFRfLpx65qwBOwrthI4WypSErwq5uf7JyVzFn/OCh6JSOzCCBaRA
         Swm/tL8H5TysCLXGh5gEXzMGk1xUkylXmUWgNqEL9e+Xdfd7Chd81kcoNxELAC0qm6n9
         pkXO20mZCZlfz5FPdakwLiSQZvBUbkiU4QFfpS+ZEA//0pDT6JdxF+GblnmGv+7IUkY6
         8MqWdHSyNOXYjnurbWTLlW1rQsuWElF3aBICXzk8iURRL85GU+NXlZb/xATbCJb9yYjI
         4qdn/sOrAg2MowZAVMqemJdBoufgqOMybwV94E0aGPOfUrQlQAN4OQOIvLpMFHw+1q/g
         yWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990407; x=1729595207;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hTA54qBy+aOesftUvMjeJdoBuyQgW2VWBtnHQwwyFA=;
        b=MHuKWzxabixNIdONocpbMpTi25okiDIT/7ckcOmYWvzHXH2boJBDYQ7/SH0mejg2aL
         r85IpGf3noGlnKFenpNqLuz1q7b/JShCq0M6iMd8XizejB7xD1Gw72+nEFKaqagC0tOl
         SdAZCZ+jyJJ9UJX36aEY1razYGEVIuIzkMuTlPPPm1pN7+nyWnLPRj3C3WIehk56+Pwx
         yBNc22LIPOK05kfSj1EkgSEgp6tOKLqW3V3+fAc590By6c+/rBJ81JSeQLq72Z9HT9Gd
         s2UNoWdIKAqodYRy1w9SdQfElijmZkh7EREbhbZVxOjLsQFraVaSiNN4uhxkztyKsj7R
         XT6w==
X-Forwarded-Encrypted: i=1; AJvYcCWHpT539ouCAZivwoo93PWIb6f7kfzJr9P5zD9772unoZTDYv9CUJ8rfQBVGUbuz5rGbXL2yJBQfAU=@vger.kernel.org, AJvYcCWdEh+1nuFTIv8btjPwIPTeuTzXZhMSwsYryU6KILUIQCm2e/HEvkAaHKt2a/BJL8Sznv545RLrX8b4D9Y=@vger.kernel.org, AJvYcCXdEZe7N67rj3aZ06iYYtRjmasg/AWuv6jYklvElTQM3vS2fsTpEQbyGgamrPrXZrNzH9feXhcxmlEyLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCMbuniz4qJh4Qs1OBBVC0ifNPqooh/2UEhJ5HYsFaaqiemrY
	NAZqbZbjDZfHEneQQDXnmJwl2pS0uH10TIbQPxBygc9CT8m6tlbv
X-Google-Smtp-Source: AGHT+IFkfJuotDmqNzIjufBTX3MBJozj8pDqq5FdrGA19B/dmN13i1Smvv5zMpp8V8YZzwHd7d9aYw==
X-Received: by 2002:a5d:53cd:0:b0:37c:ca20:52a with SMTP id ffacd0b85a97d-37d551d4f7cmr10154486f8f.8.1728990406636;
        Tue, 15 Oct 2024 04:06:46 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf838dsm1291528f8f.78.2024.10.15.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:46 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v3 0/5] iio: fix possible race condition during access of
 available info lists
Date: Tue, 15 Oct 2024 13:06:33 +0200
Message-Id: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALlMDmcC/3XNMQ6DMAwF0KugzE3lGCjQqfeoOoTEBUtAUFJFr
 RB3b2BiYfP3l58XEcgzBXHPFuEpcmA3pZBfMmF6PXUk2aYsELCAGlAyO+lJW6mj5iGNA+lA0rS
 5Ra1ItU0t0vHs6c3fHX6+Uu45fJz/7X+i2rY7qQDyMzIqCdJUYExlG4MEj25M/dW4UWxkxCNTn
 TKYGCxKALRlfWvoyKzr+gfaNhvcAwEAAA==
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
 drivers/iio/inkern.c                   |  68 +++++++++++++-----
 drivers/iio/light/as73211.c            |  25 +++++--
 drivers/iio/multiplexer/iio-mux.c      |   8 +++
 drivers/power/supply/ingenic-battery.c |  17 +++--
 include/linux/iio/consumer.h           |   4 +-
 include/linux/iio/iio.h                |   4 ++
 11 files changed, 191 insertions(+), 115 deletions(-)
---
base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


