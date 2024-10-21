Return-Path: <linux-iio+bounces-10867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90E9A692E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF741C21DE6
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7501F5830;
	Mon, 21 Oct 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcibBnNE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB11EF0BD;
	Mon, 21 Oct 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515388; cv=none; b=Kt03PJebd6y7F6jeK8kHNdyezn0AIZg61eiRBujIrV02xDCzy8FErFbZz7LiynYo1s/k2m2Zy3BFbdvqf0M0R85x3jLkObHTi1iE34cs9zJvNMa5Ss8Yp3SasnzUh0dUoCGIg3XXnRwYAP8tmdEaYNyytZcXkVuONc5RG6+bXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515388; c=relaxed/simple;
	bh=tREfQ8541ViLxlvxsaW//+lYmAxknmpPB0HiETw3Z44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxPpHC4oo3uRWiGlRRru1s+NJo8JKIpbEPw0TaznxXC9v1+c9CnutaZTVUt6d1jOv9jN54peJSqemdMVYCQnnQIEJdxvRM7TSYGMcoUkGAxtp5IEGbh3G3PrhFIXMfY32Lw82sKsEh+AhCId+lZgFN+lT9556siax2+N3PQYXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcibBnNE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d495d217bso4401370f8f.0;
        Mon, 21 Oct 2024 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515384; x=1730120184; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhc+3nVtkGPP0v2rGu9F3yIVesKnyRlfDvzJ34+Itug=;
        b=YcibBnNE7Ht4R6nChQMhi0+KcCf8YBQMzE8pHLAWqYGc/dxCBx0Jnhc0Xn1tJlOwMf
         H1h8MhpJd7rowfe2Ilz5kwBbIaMgRO7bzox0mWigIa+VsbF7XD1ADVgQ3lReBG7O0zDB
         WSsZqPn/d+IV5DVievQtG3VUe0X7TI8VLJ10qpiHjB+9CXlBfWAOcuIECRyT6TgU1kWg
         tqEd6w/zIugwkTjbJWNSudmTKpnoNKiU0g2BCTDgT89uafutU3uS2Mi6FmyhBHTKDjPv
         CC+bpCCWoJ4WwJvEfohz0bFP0qS3JTTnQGLp1zs9jFnppTwevb6zio6XOl1XiCHWgPnh
         WeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515384; x=1730120184;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhc+3nVtkGPP0v2rGu9F3yIVesKnyRlfDvzJ34+Itug=;
        b=XHRVcijYy+/4M+JrK/pPc9k3B9Vvodo2ULoVzWE90Q2nk9DoiorSoAVC0Gj/ojnwKE
         JTL0+0d5Wx8wXyTuGLorr51dmtKqaCK6kAloOGYSjeV1V/AUonFsscNEUXZNrt0mCBGL
         McuQD9dJefwYPea9PsRmj3zp6QJhH4km4RGfUZdqdUNLbcKxaRQlJQoMCJTeC+08LApC
         +Dka+Mmv3+cpr3O6l+6C70NLK+iFNicfT2EOHVkkdyUUgyvQ1J3d2dcvBed5oSLZL1Vj
         Gpy86agVjRtlGqC7phkQmMOvujXg/9hWlbpSl3K/XeIOjKK1NcSmhagtmgnxMVOZxJvQ
         /eWw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgKN8OrEXFdnrT4+tsYid3Y+xDOC+3X/+Vi9FOPXKNumfvJnmOqHYJfQEg0vZNrMfYW1/IBKQhPE=@vger.kernel.org, AJvYcCV1/2X3+ZTsu7dWlqEtUvUz+5EKd4B6TMJU8rEwtKObBaAXPYT9D+oWoAQ2x0pZMBagEy+SGdB1qyYOMcs=@vger.kernel.org, AJvYcCX8k0UbCYhhSAkHOWv3t2rq3utD4uReGygKkSIuSlNvG1xBMMGlsummcU7edJHRYDgWZqweg1cLxKgF5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9FCopMrNBy/OXZCVQc/fA5mwBJP6SaHTLvh1aV6JXETjXaLg
	F0ligv6Dtfr/ehHnZoQyw7Disl1JdIQHtl4LyLEJXYL36grC+mRI
X-Google-Smtp-Source: AGHT+IEY7dgaL98xp8q/i7zhd1J1244T9rxDFtW77fOOBStYR1g5sQLeQia3h8s37foBheGBFNwU6g==
X-Received: by 2002:adf:fa8d:0:b0:37d:5359:6753 with SMTP id ffacd0b85a97d-37ea21d8a0emr10055282f8f.15.1729515384264;
        Mon, 21 Oct 2024 05:56:24 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93e76sm4281751f8f.82.2024.10.21.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:23 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v5 0/5] iio: fix possible race condition during access of
 available info lists
Date: Mon, 21 Oct 2024 14:54:13 +0200
Message-Id: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVOFmcC/3XPwWrDMAwG4FcpPs9DluPG6anvMXZwZbUVtE2xh
 9kIefepOYVCbvol9AlNpnIRruawm0zhJlXGh4bwsTN0TY8LW8maDQJ2EAGtyGgLp2xTS3LT8sa
 psqWTz5gcu9MQjS4/C5/ld4G/vjVfpf6M5W+509yru5AOwG+RzVmw1ANRnwdChuPlrvNPGu/mR
 TZcM/0mg8pgFwAwh7gf+J3xK8aFTcYrk8gzxDMGffed6dZM3GQ6ZYKnmGjvYohhzczz/A+TNxe
 PkQEAAA==
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
 2)               |    iio_read_avail_channel_attr_retvals [industrialio]() {
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
Changes in v5:
- Patch 2: inkern, ingenic-battery: add read_avail_retvals() helpers to
  safely use the cleanup free pattern and update commit message accordingly.
- Update ingenic-battery test trace log in cover letter after retest:
  iio_read_avail_channel_attribute() -> iio_read_avail_channel_attr_retvals().
- Link to v4: https://lore.kernel.org/r/20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com

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
 drivers/iio/inkern.c                   |  99 ++++++++++++++++++++-----
 drivers/iio/light/as73211.c            |  25 +++++--
 drivers/iio/multiplexer/iio-mux.c      |   8 +++
 drivers/power/supply/ingenic-battery.c |  22 +++---
 include/linux/iio/consumer.h           |  28 +++++++-
 include/linux/iio/iio.h                |   4 ++
 11 files changed, 248 insertions(+), 118 deletions(-)
---
base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


