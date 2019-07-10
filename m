Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90A264D37
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGJUMj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 16:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfGJUMj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jul 2019 16:12:39 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B160720844;
        Wed, 10 Jul 2019 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562789558;
        bh=arZwsIKK85xQA0UQRI89h6dbRX6S7Ni7CsW8dxaQYLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p82GYfHGIWdmUya4nJbUygxwyI1+XOLI/IFwoJT1Zp8cB1DTyNpEH7+7KTf9AsV0q
         oDRhsN5b3wKb5+e5tP2DS900oefqYJkGYEpNDfh8IrBkyBs7QcLhLNMYg5oCI96Jny
         iPqsvpaGPDJi6IIb/JpRgw/F/6eGC6IKLWLvWd5E=
Received: by mail-qk1-f169.google.com with SMTP id s145so2961310qke.7;
        Wed, 10 Jul 2019 13:12:38 -0700 (PDT)
X-Gm-Message-State: APjAAAU0YZXKZVHbMqV+kE/OaMEztOP1L8cZeK0YuswcCN0Nm0mK6nnr
        8A4xbjRYMPQOlQfmdOPT4gBPIv+MjND/hkMNAA==
X-Google-Smtp-Source: APXvYqwQaQbDjnfpDjPm50aG8sIZxLG9tal9F/o52jr9suW9/+ne9DoY/hPPTpecvjX0l3Lhm/yKc8W+Q/UblrT2nyA=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr25593665qke.223.1562789557982;
 Wed, 10 Jul 2019 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190710192155.11489-1-tduszyns@gmail.com> <20190710192155.11489-2-tduszyns@gmail.com>
In-Reply-To: <20190710192155.11489-2-tduszyns@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Jul 2019 14:12:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8iLuif-UqVzpgwOLafVYr9aOo38EMeUnmYJ0a9aQ5DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: pms7003: convert bindings
 to yaml
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 10, 2019 at 1:22 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Convert existing device tree bindings to yaml.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../iio/chemical/plantower,pms7003.txt        | 26 ----------
>  .../iio/chemical/plantower,pms7003.yaml       | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
