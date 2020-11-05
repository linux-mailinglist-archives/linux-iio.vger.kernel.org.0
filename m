Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2764A2A850B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgKERhV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 12:37:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36404 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKERhV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 12:37:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so2192371otm.3;
        Thu, 05 Nov 2020 09:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dv2j2IX/I/l00znFhoW+JDpxuQkhbNqD+Ebg4ITjnKM=;
        b=OQiNPuGOS8PC27U7DxDZ4GZDwY0Fqr0MXPDZD5FTgt71yHEhbCR47xZieF9FpPP1s5
         QAK6bKMX0ZRIHgqz8QmHunHhde2+UrRuniS4XTeths6Zycz09Ma9g+5k71IsIY8XTqmF
         xiOuRo4MhN28+vnxML9JRtOXbUL9pAncEGKa8hP0g3u1esKaC8yN3eed3fb3uPGfY5/e
         AUziv/dwIEZt8x+TSqNyDLREYrb5mvFM4+baCLBEUWMqb8VqWWHvnjpCwdu9knHpqHg+
         GKLqPjDp6tjJXz4PuKNHeFf1jT6wJxC65+rzRhvUsB6UupWTYguCwkavK7CjMSPZ4H/C
         c3Sg==
X-Gm-Message-State: AOAM5333TlSMN54wj79w8zPqdJdGh8Wfj6W3WVdXNPMUgVKW5CitHl3R
        ClmxHnzspG5Hvml3jdRECipl2yXBsg==
X-Google-Smtp-Source: ABdhPJzY761+XaO+cqI+nxdIV70y48RjWUux07frq1DknNq+HPM9FsqJdKGU59fk1Ql/5BdF0Y6fag==
X-Received: by 2002:a9d:5a08:: with SMTP id v8mr2377832oth.242.1604597840536;
        Thu, 05 Nov 2020 09:37:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm496000oib.52.2020.11.05.09.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:37:19 -0800 (PST)
Received: (nullmailer pid 1526263 invoked by uid 1000);
        Thu, 05 Nov 2020 17:37:18 -0000
Date:   Thu, 5 Nov 2020 11:37:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] dt-bindings:iio:adc:adc.txt: Add documentation
 for channel label attribute
Message-ID: <20201105173718.GA1526144@bogus>
References: <20201102142000.68916-1-cristian.pop@analog.com>
 <20201102142000.68916-5-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102142000.68916-5-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 02 Nov 2020 16:20:00 +0200, Cristian Pop wrote:
> Optional attribute for better identification of the channels.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in v7:
>  - Add this extra commit
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
