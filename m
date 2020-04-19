Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85A1AF77D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 08:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDSGGA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 02:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGGA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2020 02:06:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5EC061A0C
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:06:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q19so6365352ljp.9
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2020 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfeJJLnrE9wULarH6LYtToMMZIB/fcGQ0S0pu5nHPdw=;
        b=geCKOQBd+C9zRP2TCmdMm1G+V+vvpbgH4sN1GUt9QcRYze+4FKZZVNkaTfgDJaJp2v
         l+lHu7c45ZGK68Jzeymp/CD4v8ZepC7RVdxWT4C5mNPPXUJjBtlzZieKZchlCqoo+FZv
         8Tpnjhp9AhJCijUbZqoYb68cjIzzki1NejXV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfeJJLnrE9wULarH6LYtToMMZIB/fcGQ0S0pu5nHPdw=;
        b=pvQiw9HfyMnuc1MzpIhwSqhVBEQ7ZS3Kx27TKgx7mvhLg2ZBzFH/Ss3oHkKm5QGJgS
         TIGaklH8QIh+T0CRbaNqD4gbgKbQRD5BiB5WA6zm6l4AUrnVJOmCsuhCjT46aXomuAGC
         p+HxTTCiIeXzXInTAhOlOnDKftWsSrdjHeNNnbvrD2wzTqRIUS/6vYrV9o+JZoWx0KGR
         pLQ7fnUPH7CSHCELC0YZThrY5OvhB9VRDk+oH6coU6QK0GdW0LRGlgrkYmEOVj41d43U
         5SncIKS8T9km13zyYmgOLFddeAsnae8qigTCiX17GRrc3HZLzdiY8lxoV+5InlzVCGSw
         3nIg==
X-Gm-Message-State: AGi0PubSvIutjOxg2tP33V5JkwFlpsnYsjWF/cBPdWe0DexIw7cymT0r
        13TkaKHcGSLYyDhRjQ+2pvbOAg==
X-Google-Smtp-Source: APiQypLhTMkylKoIjAa01ViA9z3ztb878wmconh/QZ4c6yNTIQF6hMIP3Sk4ibQT6LehEF3wpHs1yA==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr6398151lji.130.1587276358464;
        Sat, 18 Apr 2020 23:05:58 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id o22sm3695002ljj.100.2020.04.18.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 23:05:57 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/2] iio: chemical: atlas-sensor: add RTD-SM module support
Date:   Sun, 19 Apr 2020 09:05:53 +0300
Message-Id: <20200419060555.14433-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Atlas Scientific RTD-SM module support which reports
back temperature data down to a millicelius resoluton

Changes from v1:
* fix borked patchset

Matt Ranostay (2):
  dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
  iio: chemical: atlas-sensor: add RTD-SM module support

 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 ++
 drivers/iio/chemical/atlas-sensor.c           | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.20.1

