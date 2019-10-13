Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54913D5671
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfJMONB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 10:13:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39882 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfJMONB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 10:13:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so21409812qtb.6;
        Sun, 13 Oct 2019 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6zLct8pBwKTifz+F0/uvdV8XqD7tdVQ+bTWtwz5Y/Tw=;
        b=fBT65KzNR7rNYopsyxFn3m7ULNKz1Pr/snP9UlIf8LvaAY1AHPh0Rf6i7K65bvD+fv
         SOMfzVEOxkdJnUoyLwZXq1/2EWSp0VJG7G9SqFkK3O9t7PlbgvQYs+Y3jA/CnAh/LGjA
         Jj1lU/pIrCTEmXMuELTBCiM6SaCgU9qVSZ53vBExTDqYe92QxPUw0cwuKsdZMbSyMyLg
         2RDMLDNE03McLFMzqBoAk6aRsJHWhyJvIZ/3uHgwJYF4+hd175L7GT4MJsKhJHAGeZPj
         Ngvf51IQAJ4oJLgm+RHRox53BKMbl4wT1G4QJx5jApRSKkzF8wUzqQx7pJXOs9+N6ZMw
         TUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6zLct8pBwKTifz+F0/uvdV8XqD7tdVQ+bTWtwz5Y/Tw=;
        b=mOHGAgs6o1AB6OlCaMTY0DTrvBXG28RBN2v1cjh4lLT3G1PutG9dnMDjXo20BkgLwz
         JUJTXLegIusJzDXPoCDXd6M4NCEHbRhMZaW39eogW1KHAWk3H6zzfZzqm3tQ6TjvGbXS
         v6to5Fd8CGyO9tYIV0xz07nkEgLZprChXqzeuHxB4TJYYrTQekWmangSdzutNlbKfefk
         9sJICubCUEE+RnGdVkQmE9ft3kxRfsY8XYD1lHEokdrYyURbu4wZfifUSzoOeiG+F6xW
         8EAQ+cbJACfqG5TVXNo2XdPT0cKaUJP2dW9OwAcza2XE/l4xPNkUgRNYhkRS+RvrXSv8
         EHvA==
X-Gm-Message-State: APjAAAUGTxHfy7doiT5ijvLdbycddzbfytDSPUdoKzM72tAKCMqVlQ7l
        1dNah4XTKNHvkmeLN0nsYd4=
X-Google-Smtp-Source: APXvYqyr3w9S8yTN0lOVNAbo5M61F7ZM4Z9oJXqfLyz72JwESsPk9DDUmej480MH2J/aManJyXb32w==
X-Received: by 2002:a0c:8964:: with SMTP id 33mr23592138qvq.241.1570975980268;
        Sun, 13 Oct 2019 07:13:00 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p36sm9805447qtc.0.2019.10.13.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 07:12:59 -0700 (PDT)
Date:   Sun, 13 Oct 2019 11:12:56 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        stefan.popa@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: Add driver support for AD7292
Message-ID: <20191013141252.4ogu4sur5jea54ow@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds a basic driver for the AD7292 ADC/DAC system along
with device tree binding documentation.

Marcelo Schmitt (2):
  iio: adc: Add driver support for AD7292
  dt-bindings: iio: adc: Add DT docs for AD7292

 .../bindings/iio/adc/adi,ad7292.yaml          |  71 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ad7292.c                      | 350 ++++++++++++++++++
 5 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 create mode 100644 drivers/iio/adc/ad7292.c

-- 
2.23.0

