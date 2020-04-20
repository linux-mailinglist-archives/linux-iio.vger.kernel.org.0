Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4035C1B18CC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgDTVvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 17:51:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39541 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgDTVvg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 17:51:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so9527899otf.6;
        Mon, 20 Apr 2020 14:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p7UDp6VFOvZVJd86c+X78VAVI+WZaZqOQqo82HUqcl8=;
        b=EG7usU7xDEJ5IkKw+OGzgjlFmUOiLSpNTeqprpzrBm5lGG+WPGsD0aj6NzNG0LXwsj
         iFbCbdhXLCB9yhzzP7E0kgrXR3wt7ldWof9jeZfjJ1SP0f86KjNOezkpcqA+6gEQZIq1
         Ra5XAeMko4NP49jkzhrL/J6v5txX1CdLw8l/eTtfJUesdGUNnhGmxmB0kxrbxbVjxQFH
         DCnjjeZbIRjODmNL3AF0oMQvLhUqGNz5uen47UTz9huTwJZKsarzNy08e2HvDoOxaDDA
         F4DJxokptQHYgsUfCcgX7MVPdxQEN0uT4rAMjxRVlPC9IDq3BWRX6XIXuXWewDQg9lQR
         euYQ==
X-Gm-Message-State: AGi0PubVxWnLGcRJ8vOqPgbyV8UGvE95U0LsT8qW8C3EtPNjN9JfXxI/
        bDTIK0Z80FnJ+pXLmLLJSQ==
X-Google-Smtp-Source: APiQypLlCMJKSpvw5YK2vDoQx6DBM4WD7lw4e0YXtQbavcaOPNtRq8AFpJJ7cLo5k+2x49wbeu8Uww==
X-Received: by 2002:a9d:6142:: with SMTP id c2mr11782100otk.92.1587419487306;
        Mon, 20 Apr 2020 14:51:27 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n184sm177819oia.40.2020.04.20.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:51:26 -0700 (PDT)
Received: (nullmailer pid 26126 invoked by uid 1000);
        Mon, 20 Apr 2020 21:51:25 -0000
Date:   Mon, 20 Apr 2020 16:51:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] =?iso-8859-1?Q?dt-bindings?=
 =?iso-8859-1?Q?=3A_Add_an_entry_for_W=FCrth?= Elektronik, we
Message-ID: <20200420215125.GA26070@bogus>
References: <20200415065535.7753-1-saravanan@linumiz.com>
 <20200415065535.7753-2-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415065535.7753-2-saravanan@linumiz.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 08:55:32 +0200, Saravanan Sekar wrote:
> Add an entry for Würth Elektronik GmbH, we
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
