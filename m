Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011FBF23F9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKGBGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 20:06:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37284 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBGQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 20:06:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id d5so540283otp.4;
        Wed, 06 Nov 2019 17:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fElVYnCBpd3KgVt/n5TJlXDJPqcqZZhgcyJcqAnI0Z0=;
        b=JvESK+FiLwWUP6ic//WZw4GrpMm4EA7DFF7Vy0G1Ss70zUOTiV7uVuY48QthHSFWtJ
         0O5Z2708tq3XyS6glby8aiBGOEVDekzdiZkUFysfZvz2DN273wY0F2HUc/BBAgqIvOvw
         cS0wzuy8UScrva+sbxvdk0IE83Fh+J7nNLdPVn86HVa+OpOTeIJ9d0TYltNrXnX6VZ+S
         5Bua/pafuuNNZZRIaimQUHgMXTcvlQftaQq2SI3PzYPUJ5qZ4XE3JPUFbgGT7L9MirvZ
         AIQY6PA2YUIl0A5IPfGRkSfN1RVo35xF41lyHa3vhptmqpGxWoYGKR65sDOa6R+689mp
         bA4A==
X-Gm-Message-State: APjAAAUMCAXYa1EMUwvmd/xGf0g+/uO7sVCFtspQnMI4ir4XUKl8NCjx
        Xd5P0Jg+u4y/t3CiyU7nOg==
X-Google-Smtp-Source: APXvYqzXMVcJiKOZkHwWTnqHKRtHqH8B0hdPPXQhiOq2feptmfc4GdwTHvQ+D/XQz240EVHjM3S6dQ==
X-Received: by 2002:a9d:baf:: with SMTP id 44mr579975oth.182.1573088774892;
        Wed, 06 Nov 2019 17:06:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b24sm144894oib.43.2019.11.06.17.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:06:14 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:06:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Migrate LTC1660 documentation
 to yaml
Message-ID: <20191107010613.GA8258@bogus>
References: <20191106111233.6905-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106111233.6905-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 06, 2019 at 12:12:33PM +0100, Marcus Folkesson wrote:
> Rewrite bindings to use json-schema vocabulary.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v2:
>     	- Remove description for reg and spi-max-frequency (Rob & Alexa)
>     	- Drop maxItems for vref-supply
> 
>  .../bindings/iio/dac/lltc,ltc1660.yaml        | 49 +++++++++++++++++++
>  .../devicetree/bindings/iio/dac/ltc1660.txt   | 21 --------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 50 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> new file mode 100644
> index 000000000000..505b3d54b81c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>

If you own copyright to the old binding which I assume you do if you 
added it here, can you add 'BSD-2-Clause' to the license. Same for the 
other conversion.

Reviewed-by: Rob Herring <robh@kernel.org>
