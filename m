Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70C322A8FD
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGWG3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWG3t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 02:29:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074F5C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a1so5105719ejg.12
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQWeEJXTOpNmHd4uIX5ocGD0ExYxzn/nCbW2z8ts1Cg=;
        b=YU7abTCQZF/vdPcF8WhppgqNu6J5/V1A6GBGoT7k84IqzHRtJA0O15vJqoSJ4x2ioH
         0bye3aP0NL1kdqrp+4UL/9uBWVWXkztEXsc8s3WinS5F+CVNJFcc/5CS5u+mPDrxTSPH
         QqD2JpIxon3HjrqaZ8yIKj5vFLwaLbVbGUF4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQWeEJXTOpNmHd4uIX5ocGD0ExYxzn/nCbW2z8ts1Cg=;
        b=etryeWZvSHgC1FsoHjdOFOgg85xOU91aryRZ/mZVwPnTRvAn+p99wn7vibOfwIwsi1
         x55DQANxUP+incmDi8cvtleHsfLPAQq5OieBljnvYlHETX8DT2EeDtw5umlWLcHBNNIe
         OYauk+JieCavAG+N/EbkNCiBC+GwQHFDNC+oIECsXS+GoEIIzXeEs3Ct8YK+in+Hdj9f
         w3mMbP94Ew5NhLoFNzBVTQEZkQvhe8Q04RpbI6BN3tJyOg5fQ05nx7HEcHGsQSTa2xxs
         2mZzAwctstVOHG3MaykeA3b9VMA14kuJYuk6aQJrrAJfGcpp1Di711m7vsQqMfh2UdEx
         5vPw==
X-Gm-Message-State: AOAM531eLoh4pAM9fpxPr1jFiw38a9PlQNludjiLTOLkNsX8ux1df6l8
        H4jhL9dWjt3imoYoSQOD+bXrDw==
X-Google-Smtp-Source: ABdhPJxHzziDoi22eL4DmzSnDAA2j01amuDWzh6pYumjG8bQPPd50pTdRTAERgu+ZJgohg5dBACobg==
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr2881777ejg.307.1595485787658;
        Wed, 22 Jul 2020 23:29:47 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id bq8sm1358866ejb.103.2020.07.22.23.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:29:47 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 0/2] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Thu, 23 Jul 2020 09:29:42 +0300
Message-Id: <20200723062944.11438-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes from v1:
* rebased on modifier changes for IIO_MOD_H2/ETHANOL string identifiers

Changes from v2:
* change in atlas_ezo_sanitize() to use memmove()

Matt Ranostay (2):
  iio: add IIO_MOD_O2 modifier
  iio: chemical: atlas-ezo-sensor: add support for O2 sensor

 Documentation/ABI/testing/sysfs-bus-iio |  2 +
 drivers/iio/chemical/atlas-ezo-sensor.c | 73 ++++++++++++++++++-------
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 +
 5 files changed, 60 insertions(+), 19 deletions(-)

-- 
2.20.1

