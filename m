Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884A5F4D93
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2019 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfKHNze (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Nov 2019 08:55:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36003 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfKHNze (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Nov 2019 08:55:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id y10so6578069qto.3;
        Fri, 08 Nov 2019 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1ikag6bSZ0eCN7wwCHRChu0lBnRPoED7I4M1hqoKUdY=;
        b=s4ZzLVYOMJCoTlwZHpe25JMCQ2NRQND8JzH25vfMDoIdZBdPiHD61LpltjVedeN4fW
         j5EUfP6vyPWBQffboP+AIj18SzxULI9kBIMRxhjDCKS8kXHRGynMIT8By6sSiiz2zxaG
         5vHTW9gnC1WJU0305YNyiHbwtqLzi3f36V8U5/C5uJZItGyWPc+NwKtqB7K5w6vl0P72
         we8fB+y7WbZFfx0BEjAEs5Vd6gqQYtQbums4g9r96tuH2MdjRspqcMMSFVbq3lbxaUQ6
         XiVxeNhy1CdABBfXaMje0kkXkf4UerFmN+C4eTA6gAkfAiGP6LxyFd1sSKgcugwFWsbv
         tTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1ikag6bSZ0eCN7wwCHRChu0lBnRPoED7I4M1hqoKUdY=;
        b=iqyBY8hYXq8nNASv+T7zsoJurm4AZbJ8xIyLp5HHPJTOv7/iZmj5TcZYYrt2JsUHDJ
         zcMvIVkpfyZk/D3fDvsOpUBjEF+yyFgrakmawF/YlyyPDqtk64/ocuuKW4bppoZKorV3
         S7WQrN60WiuRofrEKFzIlSs2pa1q7lYgg0w4XMH5GpnjvvPOhDXaOoUT0QhAi/PerIoD
         sqT8L75SZQuvROZ29kb8k4EDZXIVbZw0OI0TgM7IDxhjl6dANb3fqL7LeNsdmaa8HJQu
         ry7e5Bqt3nY8aut0A3kIlT27il0ey/sb4dbiFGyhgTPVcmjUrbSliyVb5VOpv21to/27
         IAzw==
X-Gm-Message-State: APjAAAWHIhKXP7fTiCBshVqCLca1kcNpAfguen1V0/l+wqQh6MiZIBP+
        SXEtuaRkN2zNFVjYxwFQ44Q=
X-Google-Smtp-Source: APXvYqw/GH6PiCQFOfz/yT3uVIv0OGRs4v0gq7Kk0f61TESAAuUMLjQnqAFQEEqTTh4MPX0folAOQA==
X-Received: by 2002:ac8:6f57:: with SMTP id n23mr10539690qtv.46.1573221333396;
        Fri, 08 Nov 2019 05:55:33 -0800 (PST)
Received: from smtp.gmail.com ([2804:d43:422:3955:b4df:7a81:96e1:236e])
        by smtp.gmail.com with ESMTPSA id f39sm3047208qtb.26.2019.11.08.05.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:55:33 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:55:27 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org, robh@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 0/2] iio: adc: Add support for AD7292
Message-ID: <cover.1573145089.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a basic driver for the AD7292 ADC/DAC system along
with devicetree binding documentation.

Changelog V4:
- dt-binding: updated SPDX identifier to GPL-2.0-only
- dt-binding: changed maxitems constraint on channel property
- ad7292: added brackets to shield macro parameters

Marcelo Schmitt (2):
  dt-bindings: iio: adc: Add dt-schema for AD7292
  iio: adc: Add driver support for AD7292

 .../bindings/iio/adc/adi,ad7292.yaml          | 104 ++++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7292.c                      | 350 ++++++++++++++++++
 5 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 create mode 100644 drivers/iio/adc/ad7292.c

-- 
2.23.0

