Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77EDFD0C3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 23:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNWML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 17:12:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46856 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNWML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 17:12:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id n14so6764004oie.13;
        Thu, 14 Nov 2019 14:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MuYayFgV9Txkwisv1aDmW8/y0KcXnB9JehAybbEgv9k=;
        b=fUe6wBB4Md3CHAZ4+3IF0iagRFDRYfeQCsSK8Qj6G218YDQOuof321mt1Los3rRFJI
         EHwtjUWiKhKTCqPmLyGBz3MLeANJjHruE3SBUEw3qG9DzznoF0iwa9wYYH8BuhkZZLgg
         6I/P7QneZazZknwTC51uyIYd5g2WGf4gt4BBl2rOFBsKpdkp+EiVB7q6qIdLfDROZbxN
         DOGKOeAeWVYrxuCSmO7JMkp48s0RC6TghYxuc1AKbuHa79o7qPBPGzO9+sXrd3+kfLt2
         6mqPUmJEyZHIi24/4WObsltZZ7w2KQqi0lUDxH+Eh4BxhfOyRi2+wY3Jo2iQr4Id6BZ1
         zwoQ==
X-Gm-Message-State: APjAAAWcb6B6/PbH5GbU2vOuvUJGeG3sjPBDtyq18MIcWOs+Fv/U3LHP
        g4zDlGPOq9Xks5HHDkBxSQ==
X-Google-Smtp-Source: APXvYqyt3fj7h5jduriAaMs0c1KBLJJTi+ofWUC480KU8O7Sb9OBTk4SmD5IA/lHidAxKidB9itRfA==
X-Received: by 2002:a54:4e85:: with SMTP id c5mr5276950oiy.71.1573769529947;
        Thu, 14 Nov 2019 14:12:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a25sm2291719otr.30.2019.11.14.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:12:09 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:12:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [v2 9/9] dt-bindings: iio: maxim_thermocouple: document new
 'compatible' strings
Message-ID: <20191114221208.GA2764@bogus>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
 <20191111153517.13862-10-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111153517.13862-10-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Nov 2019 16:35:17 +0100, Andrea Merello wrote:
> Now the maxim_thermocouple has new, more specific, 'compatible' strings for
> better distinguish the various supported chips.
> 
> This patch updates the DT bindings documentation accordingly
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  .../bindings/iio/temperature/maxim_thermocouple.txt        | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
