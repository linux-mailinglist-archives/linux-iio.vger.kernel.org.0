Return-Path: <linux-iio+bounces-10264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7CB99271B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A91C227E0
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC14187350;
	Mon,  7 Oct 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUdAtgYt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120A38F97;
	Mon,  7 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290281; cv=none; b=sqDhg9ZXKyaqI+GYbrJmO9SuZIjZDEAfvRQUgNcVW1h6vr3FGXjbZOEui6qb7rLjfIrmlG5HDX+2nEcEdtOfFZg2vwAmJqcDY2Br4zAILyBdTz0m/fh+KtWOTyCegi+bzpqt6+VrVVrMPWhAKs4AkdGGn76hxMtmENKeSjv+yUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290281; c=relaxed/simple;
	bh=Oeh5joalKy2O1l1ofs7SMwVAjlzWpMmner7kCMi4Ht0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sySHF4u02moD+vWhO6s/4wVjqIAX0DFy0FlsvlcvWebgJS2OBcqguE2lgdaJ1Gns7NaYalRH5/rbAIHc2a+YynsfQ5cMeoWl2PXd81oos0WEfcJ3CmziwMdiwPjvgTV0vNu7CIDMyy4R9MDJAk5YL8qS/4pxqCRDLPiRsveH9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUdAtgYt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9960371b62so20265066b.3;
        Mon, 07 Oct 2024 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290278; x=1728895078; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1KCefhIgB4CxeRwKM8FJGG9oAd37UtqwBPKKJLl0eM=;
        b=kUdAtgYtFHjbZnUAfZ74ogHZKNcGaZ24en/Ia6KClgkPEh7+AsduKaMDALDm5vPwm2
         nD44tBaSK8v1vanrBLYSXhbhUaRteUnDER7R8DbeZOUGBolNOkSvvhtTPrfHyuZhLzxs
         TEYoqCu3EVb37pho3vVfwr0RyFldTKpeNOKoQ2YUKvzvwD2wWyZnJTpNsL6cfYrAFpjT
         qrzey6MqSlit/vGZpqqKnJhgUkzQxAQUEvvAyDsUQlixekGjBEfldqbKyfkU5oK8zqqv
         lQj78q2XfbQzRMSiB0BnGCpzn8GuEpNHCqzjhX5FtTrb/vElPxgB+GyX49ttkcBR5xWr
         R+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290278; x=1728895078;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1KCefhIgB4CxeRwKM8FJGG9oAd37UtqwBPKKJLl0eM=;
        b=bmc7biUUHEoWRYGTa/ISS9SIJg0vdqckEMzWZn2nREaBXtB51dzQ2v1QmVJKJdaj+a
         BFRwGrpy7RpyJ/O9rd7XiPhpX93iImGqdE7Vu8o9M6qKz1VJ9QUne2GBD3+Doj6lFsu/
         70LdlyKy4ZwIMB3tRJ6TZ5TedpupfdNLvSHXkPoaeF359B5oqqlBHhJp0GvfIFIWSw2V
         r1T0xrEBUapqqbc9Grz13t6ef189a0RKHAJ7XOiD6SMB2ya55qcbAO301NI+4eYAUtSq
         2eR8LJhCPmZFGpAsz5Lryy3qbCQu+jlm2tBe2eZ2FfyASxBSNf55u7mw5JohSoqrevXO
         EfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9LelcPDNtRQwy9UQo7iJXuMz9r3EqF2CEPMR5WlZljqZXhc7DnBO/3qr1/ItInW8ApHxvbq73IgV6NKU=@vger.kernel.org, AJvYcCUP/qzjSk0XebSC8skQjY8pjFBPcwzchmcQjabXx2hu+DHyl8dyD3hmD9DQdufd4xCZ8RbQ5kc91mUa4Q==@vger.kernel.org, AJvYcCUwBsDOP7y4CFlF6k+hckwl4GD5QU+azM5lTLy3rChQEO7cwsO35TSaO+L3iP0Mm3jxFRVviQ46E7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFjQKP2A6mwj8rmnj3/stT6PFpV2gu58AEM6hGZy/n9FFA0h5
	GIsQbHgwn8HZ/c7rNHdmBUM8wuFLemXb82F4t5F+IYOdJEfjT2j5
X-Google-Smtp-Source: AGHT+IFEVoWgG2fpExbT8FyoATYywnhQ5M1s4in44ZtXMWi9nC+Tq5efNSh4l4HI03lMwMpOSB5NcA==
X-Received: by 2002:a17:907:26c7:b0:a86:fa3d:e984 with SMTP id a640c23a62f3a-a991bd401d1mr1270869366b.20.1728290277768;
        Mon, 07 Oct 2024 01:37:57 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b24e9sm349974166b.156.2024.10.07.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:37:57 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: [PATCH v2 0/7] iio: fix possible race condition during access of
 available info lists
Date: Mon, 07 Oct 2024 10:37:09 +0200
Message-Id: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWdA2cC/3WNQQ6CMBBFr0Jm7ZhpMQFceQ/DokxHmASoaU2jI
 dzdyt7dvP/z32yQJKokuFYbRMmaNKwF7KkCntw6CqovDJbshVqyqBowivPostO5nLO4JMhD7a0
 zYoauhTJ+Rnno+xDf+8KTpleIn+NPNr/0UBqi+p8yGyTkhpgb37EVuo1L6c8cFuj3ff8C1ew8C
 LwAAAA=
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
Changes in v2:
- Patch 4: as73211: remove one blank line
- Patch 6: consumers: fix typo in commit message
- Patch 7: ingenic-battery: add missing header include
- Link to v1: https://lore.kernel.org/r/20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com

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
 drivers/iio/light/as73211.c            |  22 +++++-
 drivers/iio/multiplexer/iio-mux.c      |   8 +++
 drivers/power/supply/ingenic-battery.c |  17 +++--
 include/linux/iio/consumer.h           |   4 +-
 include/linux/iio/iio.h                |   4 ++
 11 files changed, 185 insertions(+), 114 deletions(-)
---
base-commit: fec496684388685647652ab4213454fbabdab099
change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


