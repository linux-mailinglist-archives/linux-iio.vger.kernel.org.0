Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E52A241
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2019 03:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfEYB0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 21:26:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45939 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfEYB0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 21:26:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so10075264qkk.12;
        Fri, 24 May 2019 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tWKnOMZxNyMNwzYk45X7EaXGwybTUYTh1qQHOS+4w8A=;
        b=Qk65FkiK2Q5mWeOxyFhgyouEzc6P0t0hBNf4R9rNIc7dksuqrzSopGOmE3M4R/axHj
         WZ3Xb6oA9FrdMGDhMQuh+FTTWcQTv7aDluYW9ION7otI8IPR5WWWiyF4kj/LOmbSJaYm
         wS/oPl9UxScC/6c1fG8Z1Ki0fFZy7jjsee65WpvzXsZaJuZJoeV1W0lcy63X0b2HMWRm
         e++kgwXKPpOsbgQRLabjemThTY923aoBQrTSlf1vFimBwEB5vr90w5R7mcKfI7r2rdus
         WhaFMX3V9FZxIewqCZp3M3TBIQhU9BNi+QXPdqeliLwO/zWBczu6g5/cuILOzuQMl6I5
         bNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tWKnOMZxNyMNwzYk45X7EaXGwybTUYTh1qQHOS+4w8A=;
        b=JivWE1w/QquxMVaOAEPsaAIswe9kUDhKc0jtqsI5UoB2S/LFiQbfGZ6iWAFO+b0JrJ
         0bTDtsw1ok+vpiaZfrT0WiJDQGTRD90inUHuhu3fPgRo9dMmVHSUyiFbBxyGp6ijTd/T
         y+3uD7trruq8+oI/awIjKCVOtCuOZ64QqvY4pPWpmqawGZjPXFJUdazxHv23jUu2p9Y4
         SOP8hlh3oEDzsbFdyrwvMzztDAVpesVYHDfAAD96+MHWdM2v62sxLnDvZ5Byp+qGx7P/
         0UNyIUqTq8jDN+Td6Won/snRPHc68W9rhBmRhvia6c1pyIqDA67w1YBnOlOoCPfGuMDI
         8+0w==
X-Gm-Message-State: APjAAAWrIojeNMBQfJVo7ryWhRB6OyLH1zkuXHxpIuVWyelbRkASdKR3
        YC6krxk0ytoRvWSh+jQVzwM=
X-Google-Smtp-Source: APXvYqw9DhZ1ZuGEJFQ3f7WQMR3SVYv51bgucQVPQlBA6Yokn4aEqtmJsDlp0aNsEydxEZgm4vHq7g==
X-Received: by 2002:a0c:ae0d:: with SMTP id y13mr19569814qvc.114.1558747575906;
        Fri, 24 May 2019 18:26:15 -0700 (PDT)
Received: from renatolg ([186.220.0.156])
        by smtp.gmail.com with ESMTPSA id c16sm1655731qkb.15.2019.05.24.18.26.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 18:26:15 -0700 (PDT)
Date:   Fri, 24 May 2019 22:26:10 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] dt-bindings: iio: adc: add ad7780 yaml and
 MAINTAINERS entry
Message-ID: <cover.1558746978.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset converts the old ad7780 device-tree binding to
the new YAML format, and adds an entry to MAINTAINERS.

Renato Lui Geh (2):
  dt-bindings: iio: adc: add adi,ad7780.yaml binding
  MAINTAINERS: add entry for ad7780 adc driver

 .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
 .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 3 files changed, 96 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml

-- 
2.21.0

