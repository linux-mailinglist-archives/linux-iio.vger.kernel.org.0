Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8122F7A1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 20:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgG0SVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 14:21:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38345 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgG0SVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 14:21:40 -0400
Received: by mail-il1-f193.google.com with SMTP id s21so13923234ilk.5;
        Mon, 27 Jul 2020 11:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxKFsPdFzHY3vM6sHu99sZ/6dGU9yRgpHVILpUOOBXE=;
        b=P/2DmQ+k9xSMEM52EUHzYgBugJ+eh8Zd1X1lll2v9tSS1rMCLmQYfWZMkFCHSMBnHc
         v1kU12hfMeuNcplTvCQ34IA5sMZA9Z2kQQrIPMm6Y+JdRjHYipXy3/J8tc2BjDV88FXO
         jgevkKfuOtjheFXBmEDjrqd3oCEHMO0nfcbPjgqSIuk1WlDBanoBHH1xgv5bs4nnS/tD
         ZyivrwqmXMBDYYQGTxsnqorZb21ZBQuY8OILYHOvWX5ndlHBF2X9Bs00MIo12KFou9hq
         UBiBScDkTBl/rkTt4NUI5fty/11cri7qQ8d0mi6NMLHqW6UdvvaBLzpJXiEQc95zFw4o
         VXPg==
X-Gm-Message-State: AOAM530BxeOExtU1mMQLgTNDmYEe1mfyDQr+UTgYhcdwMegfejZhu6MQ
        lq9ovjPGB/9zvawAIeO0ww==
X-Google-Smtp-Source: ABdhPJxOaozbqAIHrqpvdZ6Efnkm8Dt1ns0gHMaSVZ9NIrVeq92jjANSz5RVi9ll/rDXILrJRfZRwA==
X-Received: by 2002:a92:99d9:: with SMTP id t86mr3943448ilk.221.1595874099569;
        Mon, 27 Jul 2020 11:21:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q1sm911551ioh.0.2020.07.27.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:21:38 -0700 (PDT)
Received: (nullmailer pid 651936 invoked by uid 1000);
        Mon, 27 Jul 2020 18:21:36 -0000
Date:   Mon, 27 Jul 2020 12:21:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200727182136.GA651885@bogus>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
 <20200727161814.14076-10-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727161814.14076-10-alexandru.tachici@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Jul 2020 19:18:14 +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
