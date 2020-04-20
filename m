Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC73A1B15BF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 21:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgDTTRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 15:17:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39934 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTTRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 15:17:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so9138212otf.6;
        Mon, 20 Apr 2020 12:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ub3E7adIUaTOZ0d2h6gOjJTm+Q700wIpBk3EfoZu4d0=;
        b=s/0UoSbFOhpIbsl54N2ESjkUqEXeakXZh4joN7ngVGnkJ9JUIXFekDMLvc1zXzg97b
         MLjxhBbuEGRhP+xP4hgaL/pyBpd6N99fOIpj7tNV/Lv221htACQr4m9ZY0k9KxpyIVuR
         v6xiVXCH1egyhPLv5vbk/qBrTPW1LD+MTjKvKOMHs7/6p2g/LdNsxNoPQOLmH8tRe3Ne
         E8ZFqV4s91sUsSn7ReuD5rf+m6syEJ8IssaVTR762lXPiJ5dx+pqq44UBKfsg+7ssGyO
         nNIHscW632ToEkptYAq2peyF7GO+NpeDtViQtyoyrt7Kk6kodvpt6NU2TXWee/4TAv05
         2uEw==
X-Gm-Message-State: AGi0Puas8YT9aTbIMSF95xz+oudlhxy82g+pyi85QsQ5CTCwb66aYdIz
        f5Z3t3tkwvLOhAJ94EHp8Q==
X-Google-Smtp-Source: APiQypJDYVnfDuJjrQnhyYiYpGJgg8Yjc8BmLRYyQh4810CC6E0IQxG6a8oxfpoglcwaudC1A+cB7w==
X-Received: by 2002:a05:6830:4c8:: with SMTP id s8mr10643398otd.198.1587410234520;
        Mon, 20 Apr 2020 12:17:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q142sm71471oic.44.2020.04.20.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:17:13 -0700 (PDT)
Received: (nullmailer pid 5971 invoked by uid 1000);
        Mon, 20 Apr 2020 19:17:12 -0000
Date:   Mon, 20 Apr 2020 14:17:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v5 6/6] dt-bindings: iio: Add adis16475 documentation
Message-ID: <20200420191712.GA5911@bogus>
References: <20200413082445.17324-1-nuno.sa@analog.com>
 <20200413082445.17324-7-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200413082445.17324-7-nuno.sa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 10:24:45 +0200, =?UTF-8?q?Nuno=20S=C3=A1?= wrote:
> Document the ADIS16475 device devicetree bindings
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
> Changes in v2:
>  * Remove burst32 property;
>  * Rename clk-mode to adi,sync-mode;
>  * Remove clock-names;
>  * Add conditionals to state that clocks is only needed depending on adi,sync-mode property.
> 
> Changes in v3:
>  * Make use of 'allOf' in conditionals.
> 
> Changes in v4:
>  * Nothing changed.
> 
> Changes in v5:
>  * Nothing changed.
> 
>  .../bindings/iio/imu/adi,adis16475.yaml       | 137 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
